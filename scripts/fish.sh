#!/bin/bash

# install fish
echo "🚀 Installing fish..."
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish

cp ~/dotfiles/origin_dotfiles/config.fish.org ~/dotfiles/config.fish
mkdir -p ~/.config/fish
ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish

# install man.fish
mkdir -p ~/.config/fish/conf.d
wget https://raw.githubusercontent.com/decors/fish-colored-man/master/functions/man.fish -O ~/.config/fish/conf.d/man.fish

# install starship
curl -sS https://starship.rs/install.sh | sh
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# Ask about proxy settings
echo "Please choose whether to set proxy ([y]/n)"
read -r proxy_choice
proxy_choice=${proxy_choice:-y} 
if [[ $proxy_choice == "y" || $proxy_choice == "Y" ]]; then
    # ask about wsl version
    echo "Please choose whether to use localhost ([y]/n)"
    read -r localhost_choice
    localhost_choice=${localhost_choice:-y}

    if [[ $localhost_choice == "y" || $localhost_choice == "Y" ]]; then
        echo 'export hostip=\"127.0.0.1\"' >> config.fish
    else
        echo 'export hostip=\"$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')\"' >> config.fish
    fi

    echo 'export https_proxy=\"http://\$hostip:7890\"' >> config.fish
    echo 'export http_proxy=\"http://\$hostip:7890\"' >> config.fish
else
    echo "Proxy settings cancelled."
fi

echo "Fish installed successfully! 🎉"