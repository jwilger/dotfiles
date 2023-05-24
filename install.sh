#!/usr/bin/env zsh

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

# link gitconfig
ln -sf $DOTFILES_LOCATION/gitconfig /home/$USER/.gitconfig

###
# Install dependencies
###

echo "Installing zsh..."
./bin/dotfiles install zsh
echo "Installing omz..."
./bin/dotfiles install omz
echo "Installing asdf..."
./bin/dotfiles install asdf

export PATH=/home/$USER/.asdf/bin:${PATH}
source /home/$USER/.asdf/asdf.sh

echo "Installing tmux..."
./bin/dotfiles install tmux
echo "Installing nvim..."
./bin/dotfiles install nvim

asdf reshim

sudo chown -R $USER:$USER ~/.config
