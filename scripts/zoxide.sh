#!/bin/bash


# install zoxide
echo "🚀 Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

echo "zoxide init fish | source" >> config.fish
echo "alias cd=z" >> config.fish

echo "Zoxide installed successfully! 🎉"