#!/usr/bin/env zsh

sudo apt install -y curl git
if [[ ! -d $HOME/.asdf ]]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
fi

. $HOME/.asdf/asdf.sh
