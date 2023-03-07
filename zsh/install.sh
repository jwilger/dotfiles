#!/usr/bin/env zsh

set -e

sudo apt update && \
sudo apt install -y zsh keychain gpg-agent && \
ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"
