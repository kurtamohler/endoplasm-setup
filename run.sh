#!/bin/bash
set -e

# Update apt packages
sudo apt update
sudo apt upgrade

# Configure GNOME settings
dconf load / < config/dconf-settings.ini
