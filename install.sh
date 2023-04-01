#!/bin/bash

echo "This is my dotfiles install script for WSL 1."
echo "Please run this script with `sudo`"
echo "Make sure you have updated SJTUG apt sources."
read

# ======== Add PPA and Binaries ========
apt update
apt upgrade
apt install -y git tmux python3 pip


# install fish
echo "Installing fish..."
apt-add-repository ppa:fish-shell/release-3
apt update
apt install -y fish

ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish
chsh -s /usr/bin/fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

echo "Fish installed successfully!"



# install nodejs
echo "Please choose whether to install nodejs (y/[n])"
read nodejs_choice

if [[ $nodejs_choice == "y" || $nodejs_choice == "Y" ]]; then
    echo "Installing nodejs..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt install -y nodejs

    echo "Nodejs installed successfully!"
else
    echo "Nodejs installation cancelled."
fi


# install exa
echo "Installing exa..."
apt install -y exa


# install zoxide
echo "Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash


