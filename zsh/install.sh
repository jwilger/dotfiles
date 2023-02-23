#!/usr/bin/env zsh

set -e

sudo apt update && \
sudo apt install -y zsh && \
ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"
