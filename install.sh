#!/bin/bash

echo "This is my dotfiles install script for WSL 1."
echo "Please run this script with `sudo`"
echo "Make sure you have updated SJTUG apt sources."
read

# ======== Add PPA and Binaries ========
apt update
apt upgrade
apt install -y git tmux python3 pip


# Ask if want to copy ssh config & keys from Windows
echo "Please choose whether to copy ssh config ([y]/n)"
read -r ssh_config_choice
ssh_config_choice=${ssh_config_choice:-y} 

if [[ $ssh_config_choice == "y" || $ssh_config_choice == "Y" ]]; then
    cp -r /mnt/c/Users/24162/.ssh ~/.ssh
    chmod 600 ~/.ssh/config
    chmod 600 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub
    chmod 644 ~/.ssh/known_hosts
    chmod 644 ~/.ssh/authorized_keys

    echo "Ssh config copied successfully!"
else
    echo "Ssh config copy cancelled."
fi


# Ask if want to copy git config from Windows
echo "Please choose whether to copy git config ([y]/n)"
read -r git_config_choice
git_config_choice=${git_config_choice:-y} 

if [[ $git_config_choice == "y" || $git_config_choice == "Y" ]]; then
    cp /mnt/c/Users/24162/.gitconfig ~/.gitconfig
    
    git config --global gpg.program "/mnt/c/Program Files (x86)/gnupg/bin/gpg.exe"

    echo "Git config copied successfully!"
else
    echo "Git config copy cancelled."
fi


# install fish
echo "🚀 Installing fish..."
apt-add-repository ppa:fish-shell/release-3
apt update
apt install -y fish

chsh -s /usr/bin/fish

cp origin_dotfiles/config.fish.org config.fish
ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish

# install and configure oh-my-fish
curl -L https://get.oh-my.fish | fish
omf install pure
omf theme pure

echo "Oh-my-fish installed successfully! 🎉"

# Ask about proxy settings
echo "Please choose whether to set proxy ([y]/n)"
read -r proxy_choice
proxy_choice=${proxy_choice:-y} 

if [[ $proxy_choice == "y" || $proxy_choice == "Y" ]]; then
    # ask about wsl version
    echo "Please choose whether you are using WSL 1 ([y]/n)"
    read -r wsl1_choice
    wsl1_choice=${wsl1_choice:-y} 
    if [[ $wsl1_choice == "y" || $wsl1_choice == "Y" ]]; then
        echo "export hostip=\"127.0.0.1\"" >> config.fish
    else
        echo "export hostip=\"$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')\"" >> config.fish
    fi

    echo "export https_proxy=\"http://$hostip:7890\"" >> config.fish
    echo "export http_proxy=\"http://$hostip:7890\"" >> config.fish
else
    echo "Proxy settings cancelled."
fi

fish

echo "Fish installed successfully! 🎉"


# install nodejs
echo "Please choose whether to install nodejs ([y]/n)"
read -r nodejs_choice
nodejs_choice=${nodejs_choice:-y} 

if [[ $nodejs_choice == "y" || $nodejs_choice == "Y" ]]; then
    echo "🚀 Installing nodejs..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt install -y nodejs

    echo "Nodejs installed successfully! 🎉"

    # Ask if want to use npm mirror
    echo "Please choose whether to use npm mirror ([y]/n)"
    read -r npm_mirror_choice
    npm_mirror_choice=${npm_mirror_choice:-y} 

    if [[ $npm_mirror_choice == "y" || $npm_mirror_choice == "Y" ]]; then
        npm config set registry https://registry.npmmirror.com/

        echo "Npm mirror set successfully!"
    else
        echo "Npm mirror settings cancelled."
    fi

else
    echo "Nodejs installation cancelled."
fi


# install clang-15 and set it to clang
echo "🚀 Installing clang..."
apt install -y clang-15

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100

echo "Clang installed successfully! 🎉"


# install rust
echo "🚀 Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Rust installed successfully! 🎉"


# install miniconda
echo "🚀 Installing miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x ./Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

echo "Miniconda installed successfully! 🎉"


# install exa
echo "🚀 Installing exa..."
apt install -y exa

echo "alias ls=\"exa --group-directories-first\"" >> config.fish
echo "alias ll=\"exa -lb --no-user --group-directories-first\"" >> config.fish
echo "alias la=\"exa -alb --no-user --group-directories-first\"" >> config.fish

echo "Exa installed successfully! 🎉"


# install zoxide
echo "🚀 Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

echo "zoxide init fish | source" >> config.fish
echo "alias cd=z" >> config.fish

echo "Zoxide installed successfully! 🎉"


# install alacritty config
echo "🚀 Installing alacritty config..."
cp alacritty.yml /mnt/c/Users/24162/AppData/Roaming/alacritty/alacritty.yml
cp argonaut.yaml /mnt/c/Users/24162/AppData/Roaming/alacritty/argonaut.yaml

echo "Alacritty config installed successfully! 🎉"


# install oh-my-tmux to ~/.config/tmux
echo "🚀 Installing oh-my-tmux..."
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
mkdir -p ~/.config/tmux
ln -s -f ~/.tmux/.tmux.conf ~/.config/tmux/tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local

echo "Oh-my-tmux installed successfully! 🎉"


# Post
echo "Dotfiles installed successfully! 🎉"
echo "Remember to init your conda environment!"
