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

mkdir -p $HOME/.config/nvim
ln -sf $DOTFILES_LOCATION/nvim/after $HOME/.config/nvim/after
ln -sf $DOTFILES_LOCATION/nvim/lua $HOME/.config/nvim/lua
ln -sf $DOTFILES_LOCATION/nvim/init.lua $HOME/.config/nvim/init.lua

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
