#!/bin/bash

# Install neovim from the latest release from GitHub to ~
echo "🚀 Installing neovim..."
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
ln -s ~/dotfiles/nvim-linux64/bin/nvim ~/.local/bin/nvim


# install NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

echo "alias vim=nvim" >> config.fish
echo "" >> config.fish


echo "Neovim installed successfully! 🎉"
