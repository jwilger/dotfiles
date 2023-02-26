#!/usr/bin/env sh

###
# Installation of packages, configurations, and dotfiles.
###
DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION;

###
# Install dependencies
###
./bin/dotfiles install zsh
./bin/dotfiles install omz
./bin/dotfiles install asdf
./bin/dotfiles install tmux
./bin/dotfiles install lvim

asdf reshim
