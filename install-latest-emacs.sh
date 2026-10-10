#!/usr/bin/env bash
# Build the latest stable GNU Emacs release from GNU FTP on Fedora.
set -euo pipefail

usage() {
    cat <<'EOF'
Käyttö: install-latest-emacs.sh [--install-deps] [--check]

  --install-deps  Asenna käännösriippuvuudet dnf:llä (sudo).
  --check         Näytä uusin versio asentamatta mitään.
  --help          Näytä tämä ohje.

Asennus: ~/.local/opt/emacs-VERSIO
Lähde: https://ftp.gnu.org/gnu/emacs/ (vain vakaat julkaisut)
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

command -v curl >/dev/null || { echo 'Asenna ensin curl: sudo dnf install curl' >&2; exit 1; }
download() {
    curl --fail --location --retry 3 --connect-timeout 30 --max-time 600 \
        --proto '=https' --proto-redir '=https' "$@"
}

base=https://ftp.gnu.org/gnu/emacs
listing=$(download --silent --show-error "$base/")
# Only stable numbered releases; exclude development and .90+ pretest versions.
version=$(printf '%s\n' "$listing" |
    grep -oE 'emacs-[0-9]+\.[0-9]+(\.[0-9]+)?\.tar\.xz' |
    sed -E 's/^emacs-//; s/\.tar\.xz$//' |
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
        sudo dnf install curl xz gnupg2 gcc gcc-c++ make pkgconf-pkg-config texinfo \
            gtk3-devel gnutls-devel ncurses-devel libgccjit-devel \
            libtree-sitter-devel libxml2-devel libXpm-devel libjpeg-turbo-devel \
            libpng-devel giflib-devel libtiff-devel librsvg2-devel \
            sqlite-devel gmp-devel zlib-devel
    fi
    for tool in curl tar xz gpg gcc make makeinfo pkg-config; do
        command -v "$tool" >/dev/null || {
            printf 'Puuttuva työkalu: %s. Aja --install-deps-valinnalla.\n' "$tool" >&2
            exit 1
        }
    done
    jobs=${JOBS:-2}
    [[ "$jobs" =~ ^[1-9][0-9]*$ ]] || { echo 'JOBS-arvon tulee olla positiivinen kokonaisluku.' >&2; exit 1; }
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/emacs-build.XXXXXXXX")
    trap 'rm -rf -- "$work_dir"' EXIT
    archive="emacs-$version.tar.xz"
    download --output "$work_dir/$archive" "$base/$archive"
    download --output "$work_dir/$archive.sig" "$base/$archive.sig"
    download --output "$work_dir/gnu-keyring.gpg" https://ftp.gnu.org/gnu/gnu-keyring.gpg
    mkdir -m 700 "$work_dir/gnupg"
    gpg --batch --homedir "$work_dir/gnupg" --import "$work_dir/gnu-keyring.gpg"
    gpg --batch --homedir "$work_dir/gnupg" --verify "$work_dir/$archive.sig" "$work_dir/$archive"
    tar -xJf "$work_dir/$archive" -C "$work_dir"
    cd "$work_dir/emacs-$version"
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
data_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}
mkdir -p "$data_dir/applications" "$data_dir/icons/hicolor/scalable/apps"
cp "$prefix/share/icons/hicolor/scalable/apps/emacs.svg" \
    "$data_dir/icons/hicolor/scalable/apps/emacs-latest.svg"
cat > "$data_dir/applications/emacs-latest.desktop" <<EOF
[Desktop Entry]
Name=Emacs
GenericName=Text Editor
Comment=Edit text with GNU Emacs
Exec="$bin_dir/emacs-latest" %F
TryExec=$bin_dir/emacs-latest
Icon=emacs-latest
Type=Application
Terminal=false
Categories=Development;TextEditor;
StartupNotify=true
StartupWMClass=Emacs
MimeType=text/plain;
EOF
if command -v kbuildsycoca6 >/dev/null; then
    kbuildsycoca6 --noincremental || echo 'KDE-valikkovälimuistin päivitys epäonnistui.' >&2
fi

printf '\nValmis. Käynnistä: %s/emacs-latest\n' "$bin_dir"
