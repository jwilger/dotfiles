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

local line_num="%{$fg_no_bold[white]%}"
local whereami="%{$fg_bold[cyan]%}"
local user_and_host="%{$fg_no_bold[red]%}"
local git_stuffs="%{$fg_bold[magenta]%}"
local punct="%{$fg_no_bold[yellow]%}"
local revert="%{$fg_no_bold[default]%}"

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function display_rvm_info {
  rvm current
}

RPS1=$'${user_and_host}%{%}%n %m:${whereami}%~%$((COLUMNS-12))(l.  %}. )%{%} $(display_rvm_info)%{\e[31m%}($(parse_git_branch))%{\e[0m%}'
PS1="${line_num}[%h%1(j.%%%j.)%0(?..:%?)]%#${revert} "

# rake autocompletion from:
# http://weblog.rubyonrails.org/2006/3/9/fast-rake-task-completion-for-zsh
_rake_does_task_list_need_generating () {
  if [ ! -f .rake_tasks ]; then return 0;
  else
    accurate=$(stat -f%m .rake_tasks)
    changed=$(stat -f%m Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

_rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

alias g="git"
alias gco="git checkout"
alias gst="git status"
alias gci="git commit"
alias gbr="git branch"
alias grb="git rebase"
alias grm="git rm"
alias gg='git log --pretty=oneline --abbrev-commit --branches=* --graph --decorate --color'

alias mkdir="mkdir -p"

alias tm="tmux"

source ~/.zshrc.local

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
