#!/bin/bash

# install oh-my-tmux to ~/.config/tmux
echo "🚀 Installing oh-my-tmux..."
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
mkdir -p ~/.config/tmux
ln -s -f ~/.tmux/.tmux.conf ~/.config/tmux/tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local

echo "Oh-my-tmux installed successfully! 🎉"