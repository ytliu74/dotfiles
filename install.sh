#!/bin/bash

echo "This is my dotfiles install script for WSL 1."
echo "Please set up proxy for your bash first!"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "This script should not be run as root" 
   exit 1
fi

echo "Please input your Windows user name: "
read -r user_name

sudo -v

# Using SJTUG apt sources
# Ask if using Ubuntu22.04-jammy
echo "Please choose whether to use Ubuntu22.04-jammy ([y]/n)"
read -r ubuntu_choice
ubuntu_choice=${ubuntu_choice:-y}

# link the new sources.list
if [[ $ubuntu_choice == "y" || $ubuntu_choice == "Y" ]]; then
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo ln -sf ~/dotfiles/sources.list.jammy /etc/apt/sources.list
fi


# Apt updates
sudo apt update
sudo apt upgrade -y
sudo apt install -y git tmux python3 pip p7zip-full ncdu

mkdir -p ~/.config/pip
ln -sf ~/dotfiles/pip.conf ~/.config/pip/pip.conf

# Call separate script files
# Define array variable
scripts=(
  "apt.sh"
  "ssh.sh"
  "git.sh"
  "fish.sh"
  "nodejs.sh"
  "clang.sh"
  "rust.sh"
  "miniconda.sh"
  "exa.sh"
  "zoxide.sh"
  "bat.sh"
  "alacritty.sh"
  "tmux.sh"
  "lazygit.sh"
)

# Loop through array and call script files
for script in "${scripts[@]}"
do
  ./scripts/"$script"
done


# Post
sudo -k
chsh -s /usr/bin/fish
echo "starship init fish | source" >> config.fish

echo "Dotfiles installed successfully! 🎉"
echo "Remember to init your conda environment!"
