#!/bin/bash

# install rust
echo "🚀 Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

ln -s ~/dotfiles/configs/cargo_config.toml ~/.cargo/config.toml

echo "Rust installed successfully! 🎉"
