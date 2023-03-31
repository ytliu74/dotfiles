#!/bin/bash

echo "This is my dotfiles install script for WSL 1."
echo "Please run this script with `sudo`"
echo "Make sure you have update SJTUG apt sources."
read

# ======== Add PPA and Binaries ========
apt update
apt upgrade
apt install git tmux python3 pip

# install fish
apt-add-repository ppa:fish-shell/release-3
apt update
apt install fish
