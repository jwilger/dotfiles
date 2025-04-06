# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch
unsetopt autocd notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jwilger/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Aliases
alias gst="git status"
alias gci="git commit"
alias gap="git add --patch"
alias ls="ls -lGh"
alias envs="env | sort"
alias envg="env | grep -i"
alias guid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias zz='zellij --layout=.zellij.kdl attach -c "`basename \"$PWD\"`"'
alias za='zellij attach --index 0'

export STARSHIP_CONFIG=/home/jwilger/.config/starship.toml
eval "$(starship init zsh)"
