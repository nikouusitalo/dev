#ympäristömuuttujat (portable)

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

export N_PREFIX="$HOME/.local/npm"

for dir in "$HOME/.local/bin" "$HOME/bin" "$HOME/.local/npm/bin"; do
    [[ ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
done
export PATH

export TIMEWARRIORDB=$HOME/vault/timew
export TASKRC=$HOME/.config/task/taskrc
export TASKDATA=$HOME/vault/task
export PASSWORD_STORE_DIR=$HOME/vault/pass
export PATH=$PATH:/usr/bin/python3
export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export CODEEDITOR="nvim"
export COLORTERM="truecolor"
export BROWSERCLI="w3m"
export PAGER="less"
export LANG=fi_FI.UTF-8
export LC_MESSAGES=en_US.UTF-8
export QT_QPA_PLATFORM="wayland xcb virtualbox"
#export XDG_CURRENT_DESKTOP=sway
#export XDG_SESSION_DESKTOP=sway
#export XDG_CURRENT_SESION_TYPE=wayland
#export GDK_BACKEND="wayland,x11"
export MOZ_ENABLE_WAYLAND=1
#export WM="sway"
export OPENER="xdg-open"
export VIDEO="mpv"

