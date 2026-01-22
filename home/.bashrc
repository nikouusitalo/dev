# .bashrc
# tab-complete
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind '"\t": menu-complete'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH



export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="ls:tree:pwd:exit:clear"
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r"


goo() {
    IFS=+ w3m https://google.com/search?hl=en\&q="$*"
}

ww(){  w3m https://lite.duckduckgo.com/lite/?q="$*"; }
alias kk="task ghistory"
alias arvio="task burndown.weekly"
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


##Alise
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}

export PS1="-> \[\e[32m\]\$(parse_git_branch)\[\e[0m\] "

