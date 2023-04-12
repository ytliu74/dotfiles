#!/bin/bash

# install miniconda
echo "🚀 Installing miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x ./Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

ln -sf ~/dotfiles/.condarc ~/.condarc

echo "Miniconda installed successfully! 🎉"