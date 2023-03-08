#!/usr/bin/env sh

###
# Installation of packages, configurations, and dotfiles.
###
DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION;

export USER=`whoami`

echo "Running dotfiles installation as $USER"

echo "Environment contains:"
env

echo "Ensuring $USER owns /home/$USER/dotfiles"
sudo chown -R $USER:$USER /home/$USER/dotfiles
echo "Ensuring /home/$USER/.config directory exists"
sudo mkdir -p /home/$USER/.config
echo "Ensuring $USER owns /home/$USER/.config"
sudo chown -R $USER:$USER /home/$USER/.config
echo "Ensuring .tool-versions file exists"
sudo touch /home/$USER/.tool-versions
echo "Ensuring $USER owns .tool-versions"
sudo chown -R $USER:$USER /home/$USER/.tool-versions

###
# Install dependencies
###
./bin/dotfiles install zsh
./bin/dotfiles install omz
./bin/dotfiles install asdf

export PATH=~/.asdf/bin:${PATH}
source ~/.asdf/asdf.sh

./bin/dotfiles install tmux
./bin/dotfiles install lvim

asdf reshim

sudo chown -R $USER:$USER ~/.config
