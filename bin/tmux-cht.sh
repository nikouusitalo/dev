
#!/usr/bin/env bash
set -euo pipefail

langs_file="$HOME/.local/bin/tmux-cht-languages"
cmds_file="$HOME/.local/bin/tmux-cht-command"

# Valitse kieli tai komento
selected="$(
  cat "$langs_file" "$cmds_file" | fzf --prompt="cht.sh > " --height=40% --reverse
)"

[[ -z "${selected:-}" ]] && exit 0

# Lue haku
read -r -p "Enter Query: " query

# Muunna välilyönnit plussiksi (cht.sh ymmärtää nämä hyvin)
q="${query// /+}"

# Rakenna URL
if grep -Fxq "$selected" "$langs_file"; then
  url="https://cht.sh/${selected}/${q}"
else
  url="https://cht.sh/${selected}~${q}"
fi

# Komento joka näyttää ensin URL:n ja sitten sisällön pagerissa
cmd="bash -lc 'printf \"URL: %s\n\n\" \"$url\"; curl -sS \"$url\" | less -R'"

# Jos ollaan tmuxissa, avaa uuteen ikkunaan, muuten aja suoraan
if [[ -n "${TMUX:-}" ]]; then
  tmux new-window -n "cht:${selected}" "$cmd"
else
  eval "$cmd"
fi

