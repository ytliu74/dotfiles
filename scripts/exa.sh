#!/bin/bash

# install exa
echo "🚀 Installing exa..."
sudo apt install -y exa

echo "alias ls=\"exa --group-directories-first\"" >> config.fish
echo "alias ll=\"exa -lb --no-user --group-directories-first\"" >> config.fish
echo "alias la=\"exa -alb --no-user --group-directories-first\"" >> config.fish

echo "Exa installed successfully! 🎉"
