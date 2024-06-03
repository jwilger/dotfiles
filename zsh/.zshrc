export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"
COMPLETION_WAITING_DOTS="true"
plugins=(git keychain direnv mix asdf pyenv)
zstyle :omz:plugins:keychain agents gpg,ssh
source $ZSH/oh-my-zsh.sh
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_TITLE=true

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  . $HOME/.asdf/asdf.sh
fi
export PATH=$HOME/.local/bin:$PATH

[ -f "/home/jwilger/.ghcup/env" ] && source "/home/jwilger/.ghcup/env" # ghcup-env
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
export TSTRUCT_TOKEN="tstruct_eyJ2ZXJzaW9uIjoxLCJkYXRhIjp7InVzZXJJRCI6MTQ2ODQ0OTYwOCwidXNlckVtYWlsIjoiam9obndpbGdlckBhcnRpdW0uYWkiLCJ0ZWFtSUQiOjE3OTM2MzAzOSwidGVhbU5hbWUiOiJqb2hud2lsZ2VyQGFydGl1bS5haSdzIHRlYW0iLCJyZW5ld2FsRGF0ZSI6IjIwMjQtMDUtMDlUMjI6MDA6MjUuMjAyNjExNzM2WiIsImNyZWF0ZWRBdCI6IjIwMjQtMDUtMDJUMjI6MDA6MjUuMjAyNjEzNTZaIn0sInNpZ25hdHVyZSI6IjI3dEhXRE1FR3B3cnRzS25iSnZZSFZxSk1IN1Q3ZFFkZUN1dGNXY0Uvc1VzOEYzTm5zYWZXUXIrVUdGbTVPK0s5T1Z1NmJybGxWV2lWV3c1L2NxckR3PT0ifQ=="
