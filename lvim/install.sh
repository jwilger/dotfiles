#!/usr/bin/env zsh

export DEBIAN_FRONTEND=noninteractive

sudo apt install -y \
  libbz2-dev \
  libncurses-dev \
  libffi-dev \
  libreadline-dev \
  libsqlite3-dev \
  liblzma-dev

asdf plugin add rust
asdf install rust 1.67.1
asdf global rust 1.67.1
asdf plugin add python
asdf install python 3.11.2
asdf global python 3.11.2
asdf plugin add nodejs
asdf install nodejs 18.14.2
asdf global nodejs 18.14.2
asdf plugin add neovim
asdf install neovim 0.8.3
asdf global neovim 0.8.3

asdf reshim

mkdir -p $HOME/.config/lvim
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh) -y --install-dependencies
ln -sf $DOTFILES_LOCATION/lvim/config.lua $HOME/.config/lvim/config.lua
