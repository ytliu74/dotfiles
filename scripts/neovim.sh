#!/bin/bash

# Install neovim from the latest release from GitHub to ~
echo "🚀 Installing neovim..."
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O ~/nvim.appimage
~/nvim.appimage --appimage-extract

# install NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

echo "fish_add_path ~/squashfs-root/usr/bin" >> config.fish
echo "alias vim=nvim"
echo "" >> config.fish


echo "Neovim installed successfully! 🎉"
