#!/bin/bash

# install bat from latest GitHub release
echo "🚀 Installing bat..."
version=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/v//')
wget https://github.com/sharkdp/bat/releases/download/v${version}/bat_${version}_amd64.deb
sudo dpkg -i bat_${version}_amd64.deb
rm bat_${version}_amd64.deb

echo "Bat installed successfully! 🎉"