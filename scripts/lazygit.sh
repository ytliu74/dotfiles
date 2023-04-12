#!/bin/bash

# install lazygit from latest GitHub release
echo "🚀 Installing lazygit..."
lg_version=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/v//')
# download into a tmp folder
mkdir -p /tmp/lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v${lg_version}/lazygit_${lg_version}_Linux_x86_64.tar.gz -P /tmp/lazygit
tar -xvf /tmp/lazygit/lazygit_${lg_version}_Linux_x86_64.tar.gz -C /tmp/lazygit
mv /tmp/lazygit/lazygit ~/.local/bin/lazygit
rm -rf /tmp/lazygit

echo "Lazygit installed successfully! 🎉"
