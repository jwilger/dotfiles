# Git
alias gst='git status'
alias gci='git commit'
alias gap='git add --patch'

# OS
alias ls='ls -lGh'
alias envs='env | sort'
alias envg='env | grep -i'

# Random
alias guid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\\  -f2"