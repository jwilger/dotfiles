#!/usr/bin/env zsh

sudo apt install -y \
  powerline \
  fonts-powerline \
  bison \
  automake \
  autotools-dev

. $HOME/.asdf/asdf.sh

asdf plugin add tmux
asdf install tmux 3.3
asdf global tmux 3.3

rm -rf $HOME/.tmux.conf 
rm -rf $HOME/.tmux

ln -sf $DOTFILES_LOCATION/tmux/tmux.conf $HOME/.tmux.conf
ln -sf $DOTFILES_LOCATION/tmux/tmux $HOME/.tmux

rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
