#!/bin/bash
set -e

# Update apt packages
sudo apt update -y
sudo apt upgrade -y

# Install apt packages
sudo apt install -y \
  vim \
  ubuntu-restricted-extras \
  virtualbox \
  gdb

# Install wine (https://wiki.winehq.org/Ubuntu)
# TODO: This doesn't work because the repository is not signed. Something must have
#       changed with it. Look for a better solution that will be more reliable in
#       the long run
#sudo dpkg --add-architecture i386
#sudo wget -nc -O /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#sudo wget -nc -P /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
#sudo apt update -y
#sudo apt install -y --install-recommends winehq-staging


# Add default directories in `$HOME`
mkdir -p ~/local
mkdir -p ~/develop
mkdir -p ~/bin
mkdir -p ~/tmp
mkdir -p ~/mnt

# Configure GNOME settings
dconf load / < config/dconf-settings.ini

# Install and activate Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init
conda activate base

# Create main conda env
conda env create -n main -f config/conda-main-env.yml
conda activate main

# Install quarter windows GNOME extension
gnome-extensions-cli install quarterwindows@troyready.com
gnome-extensions enable quarterwindows@troyready.com

# Configure git
git config --global user.name "Kurt Mohler"
git config --global user.email kurtamohler@gmail.com
git config --global core.editor "vim"

# Append various settings to `~/.bashrc`
cat config/bashrc-additions.sh >> $HOME/.bashrc

# Add webp support for image viewer
sudo add-apt-repository ppa:helkaluin/webp-pixbuf-loader
sudo apt update -y
sudo apt install -y webp-pixbuf-loader
