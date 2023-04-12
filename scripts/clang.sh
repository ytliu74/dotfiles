#!/bin/bash

# install clang-15 and set it to clang
echo "🚀 Installing clang..."
sudo apt install -y clang-15

sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100

echo "Clang installed successfully! 🎉"