export VISUAL=vim
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt share_history
setopt prompt_subst
setopt no_nomatch
autoload -U promptinit
promptinit
prompt oliver
autoload -U compinit
compinit
path=(~/bin /usr/local/bin /usr/local/sbin /opt/local/bin /opt/local/sbin /usr/bin /usr/sbin /bin /sbin)
cdpath=(. ~ ~/projects)

bindkey -v

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

RPS1=$'%{\e[32m%}%{%}%n %m:%~%$((COLUMNS-12))(l.  %}. )%{%} %{\e[31m%}($(parse_git_branch))%{\e[0m%}'
PS1=$'\n\n\n%{\e[34m%}[%h%1(j.%%%j.)%0(?..:%?)]%#%{\e[0m%} '

alias g="git"
alias gco="git checkout"
alias gst="git status"
alias gci="git commit"
alias gbr="git branch"
alias grb="git rebase"
alias grm="git rm"
alias gg='git log --pretty=oneline --abbrev-commit --branches=* --graph --decorate --color'
alias clean-branches="git branch | xargs -n 1 git branch -D"

alias mkdir="mkdir -p"

# So that vim can use the system clipboard when run inside tmux
# Note: as long as the reattach-to-user-namespace command is present,
# this works whether inside tmux or not.
if [ -f /usr/local/bin/reattach-to-user-namespace ]; then
  alias vim='reattach-to-user-namespace vim'
fi

# Returns the name of the last (right-most) directory in the $PWD
function last_dir_in_path {
  local d
  d=`pwd`
  d=(${(s:/:)d})
  echo $d[-1]
}

# Attempts to attach to a tmux session with a name matching
# `last_dir_in_path`
function tma {
  tmux attach -t `last_dir_in_path`
}

# Creates a new tmux session where the name is `last_dir_in_path`
function tmn {
  local dir
  dir=`last_dir_in_path`
  tmux new -d -s $dir
  tmux send-keys -t $dir 'tmwindows' C-m
  tmux attach -t $dir
}

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

autoload run-help
HELPDIR=/usr/local/share/zsh/help

fpath=(/usr/local/share/zsh-completions $fpath)

source ~/.zshrc.local
