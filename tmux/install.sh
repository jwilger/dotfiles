#!/usr/bin/env zsh

sudo apt install -y \
  powerline \
  fonts-powerline \
  tmux

rm -rf $HOME/.tmux.conf 

ln -sf $DOTFILES_LOCATION/tmux/tmux.conf $HOME/.tmux.conf
