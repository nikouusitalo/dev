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
export COLORTERM="truecolor"
export VIDEO="mpv"
export BROWSERCLI="w3m"

parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}

export PS1="-> \[\e[32m\]\$(parse_git_branch)\[\e[0m\] "

