export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"
COMPLETION_WAITING_DOTS="true"
plugins=(git keychain direnv)
zstyle :omz:plugins:keychain agents gpg,ssh
source $ZSH/oh-my-zsh.sh
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_TITLE=true

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  . $HOME/.asdf/asdf.sh
fi
export PATH=$HOME/.local/bin:$PATH
