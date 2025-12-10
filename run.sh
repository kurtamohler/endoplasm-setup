#!/bin/bash

# Exit script if any errors happen
set -e

# Print each command before running it
set -x

# Create ssh key
ssh-keygen -t rsa -f $HOME/.ssh/id_rsa

# Configure GNOME settings
dconf load / < config/dconf-settings.ini

# Copy vimrc
cp config/vimrc $HOME/.vimrc

# Add default directories in `$HOME`
mkdir -p $HOME/local
mkdir -p $HOME/develop
mkdir -p $HOME/bin
mkdir -p $HOME/tmp
mkdir -p $HOME/mnt

# Update apt packages
sudo apt update -y
sudo apt upgrade -y

# Install apt packages

# TODO: Unfortunately, ACCEPT_EULA does not work for the EULA of ttf-mscorefonts-installer
#       I'd really like to solve that issue
ACCEPT_EULA=Y sudo apt install -y \
  vim \
  ubuntu-restricted-extras \
  gdb \
  gimp \
  htop \
  lm-sensors \
  7zip \
  mpv \
  mpv-mpris \
  eog-plugins \
  build-essential \
  ca-certificates \
  imagemagick

# Install Chrome
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
if ! sudo dpkg -i /tmp/chrome.deb; then
  sudo apt -f install -y
fi

# Install Steam
wget -O /tmp/steam.deb http://media.steampowered.com/client/installer/steam.deb
if ! sudo dpkg -i /tmp/steam.deb; then
  sudo apt -f install -y
fi

# Install and activate Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init
conda activate base

# Create main conda env
conda env create -n main -f config/conda-main-env.yml
conda activate main

# Append various settings to `~/.bashrc`
cat config/bashrc-additions.sh >> $HOME/.bashrc

# Configure git
git config --global user.name "Kurt Mohler"
git config --global user.email kurtamohler@gmail.com
git config --global core.editor "vim"

# Add webp support for image viewer
sudo add-apt-repository -y ppa:helkaluin/webp-pixbuf-loader
sudo apt update -y
sudo apt install -y webp-pixbuf-loader

# Set default mime apps
cp config/mimeapps.list ~/.config/mimeapps.list

# Install quarter windows GNOME extension
wget -O /tmp/quarterwindows@troyready.com-v5.zip https://github.com/troyready/quarterwindows/releases/download/v5/quarterwindows@troyready.com-v5.zip
gnome-extensions install --force /tmp/quarterwindows@troyready.com-v5.zip
killall -SIGQUIT gnome-shell
# TODO: I want to find a way to check if gnome-shell is back up, but it's hard
#       to find info about how to do that
sleep 10
gnome-extensions enable quarterwindows@troyready.com

# Install `~/bin` scripts
cp -r home-bin/* $HOME/bin

printf "\n\nConfiguration is complete! Please restart your machine\n"
