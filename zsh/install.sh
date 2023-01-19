#!/usr/bin/env zsh

set -e

sudo apt update && \
sudo apt install zsh && \
ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"