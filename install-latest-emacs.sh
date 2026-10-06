#!/usr/bin/env bash
# Build the latest stable GNU Emacs tag from GitHub on Fedora.
set -euo pipefail

usage() {
    cat <<'EOF'
Käyttö: install-latest-emacs.sh [--install-deps] [--check]

  --install-deps  Asenna käännösriippuvuudet dnf:llä (sudo).
  --check         Näytä uusin versio asentamatta mitään.
  --help          Näytä tämä ohje.

Asennus: ~/.local/opt/emacs-VERSIO
Lähde: https://github.com/emacs-mirror/emacs/tags (vain vakaat julkaisut)
Käynnistys: ~/.local/bin/emacs-latest (myös emacsclient-latest)
JOBS=4 säätää rinnakkaisten käännöstöiden määrää (oletus: 2).
Nykyinen Emacs ja sen konfiguraatio säilyvät ennallaan.
EOF
}

install_deps=false
check=false
for arg in "$@"; do
    case "$arg" in
        --install-deps) install_deps=true ;;
        --check) check=true ;;
        --help|-h) usage; exit 0 ;;
        *) printf 'Tuntematon valinta: %s\n' "$arg" >&2; usage >&2; exit 1 ;;
    esac
done

if (( EUID == 0 )); then
    echo 'Aja skripti tavallisena käyttäjänä, älä sudolla.' >&2
    exit 1
fi

require_fedora() {
    # shellcheck source=/etc/os-release
    . /etc/os-release
    [[ "$ID" == fedora ]] || { echo 'Riippuvuuksien asennus tukee vain Fedoraa.' >&2; exit 1; }
}

if ! command -v git >/dev/null; then
    if "$install_deps" && ! "$check"; then
        require_fedora
        sudo dnf install git
    else
        echo 'Asenna ensin git: sudo dnf install git' >&2
        exit 1
    fi
fi

repository=https://github.com/emacs-mirror/emacs.git
# Query every tag, independently of GitHub's HTML pagination or tag dates.
listing=$(GIT_TERMINAL_PROMPT=0 git -c http.connectTimeout=30 \
    -c http.lowSpeedLimit=1 -c http.lowSpeedTime=60 \
    ls-remote --tags --refs "$repository" 'emacs-*')
# Exclude RC names, x.0 development tags and .90+ pretest components.
version=$(printf '%s\n' "$listing" |
    awk '$2 ~ /^refs\/tags\/emacs-[0-9]+\.[0-9]+(\.[0-9]+)?$/ {
        sub(/^refs\/tags\/emacs-/, "", $2); print $2
    }' |
    awk -F. '$2 > 0 && $2 < 90 && (NF == 2 || $3 < 90)' |
    sort -Vu | tail -n 1)
[[ -n "$version" ]] || { echo 'Julkaisuversion hakeminen epäonnistui.' >&2; exit 1; }
printf 'Uusin vakaa GNU Emacs: %s\n' "$version"
if "$check"; then exit 0; fi

prefix="$HOME/.local/opt/emacs-$version"
bin_dir="$HOME/.local/bin"
for name in emacs emacsclient; do
    target="$bin_dir/$name-latest"
    if [[ -e "$target" && ! -L "$target" ]]; then
        printf 'En korvaa olemassa olevaa tiedostoa: %s\n' "$target" >&2
        exit 1
    fi
done

if [[ ! -f "$prefix/.installation-complete" ]]; then
    if "$install_deps"; then
        require_fedora
        sudo dnf install git autoconf gcc gcc-c++ make pkgconf-pkg-config texinfo \
            gtk3-devel gnutls-devel ncurses-devel libgccjit-devel \
            libtree-sitter-devel libxml2-devel libXpm-devel libjpeg-turbo-devel \
            libpng-devel giflib-devel libtiff-devel librsvg2-devel \
            sqlite-devel gmp-devel zlib-devel
    fi
    for tool in git autoconf gcc make makeinfo pkg-config; do
        command -v "$tool" >/dev/null || {
            printf 'Puuttuva työkalu: %s. Aja --install-deps-valinnalla.\n' "$tool" >&2
            exit 1
        }
    done
    jobs=${JOBS:-2}
    [[ "$jobs" =~ ^[1-9][0-9]*$ ]] || { echo 'JOBS-arvon tulee olla positiivinen kokonaisluku.' >&2; exit 1; }
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/emacs-build.XXXXXXXX")
    trap 'rm -rf -- "$work_dir"' EXIT
    GIT_TERMINAL_PROMPT=0 git clone --depth 1 --single-branch \
        --branch "emacs-$version" "$repository" "$work_dir/emacs"
    cd "$work_dir/emacs"
    ./autogen.sh
    ./configure --prefix="$prefix" --with-pgtk --with-native-compilation \
        --with-tree-sitter --with-gnutls
    make -j "$jobs"
    make install
    "$prefix/bin/emacs" --batch -Q --eval '(princ emacs-version)'
    touch "$prefix/.installation-complete"
else
    printf 'Versio %s on jo asennettu.\n' "$version"
fi

mkdir -p "$bin_dir"
ln -sfnT "$prefix/bin/emacs" "$bin_dir/emacs-latest"
ln -sfnT "$prefix/bin/emacsclient" "$bin_dir/emacsclient-latest"
printf '\nValmis. Käynnistä: %s/emacs-latest\n' "$bin_dir"
