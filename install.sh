#!/bin/bash

echo "This is my dotfiles install script for WSL 1."
echo "Please set up proxy for your bash first!"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "This script should not be run as root" 
   exit 1
fi

echo "Please input your Windows user name: "
read -r user_name

sudo -v

# Using SJTUG apt sources
# Ask if using Ubuntu22.04-jammy
echo "Please choose whether to use Ubuntu22.04-jammy ([y]/n)"
read -r ubuntu_choice
ubuntu_choice=${ubuntu_choice:-y}

# link the new sources.list
if [[ $ubuntu_choice == "y" || $ubuntu_choice == "Y" ]]; then
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo ln -sf ~/dotfiles/sources.list.jammy /etc/apt/sources.list
fi


# Apt updates
sudo apt update
sudo apt upgrade -y
sudo apt install -y git tmux python3 pip p7zip-full ncdu

mkdir -p ~/.config/pip
ln -sf ~/dotfiles/pip.conf ~/.config/pip/pip.conf


# Ask if want to copy ssh config & keys from Windows
echo "Please choose whether to copy ssh config ([y]/n)"
read -r ssh_config_choice
ssh_config_choice=${ssh_config_choice:-y} 

if [[ $ssh_config_choice == "y" || $ssh_config_choice == "Y" ]]; then
    mkdir -p ~/.ssh
    # copy config, id_rsa, id_rsa.pub from local windows
    cp /mnt/c/Users/$user_name/.ssh/config ~/.ssh/config
    cp /mnt/c/Users/$user_name/.ssh/id_rsa ~/.ssh/id_rsa
    cp /mnt/c/Users/$user_name/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub

    # change permission
    chmod 600 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub

    echo "Ssh config copied successfully!"
else
    echo "Ssh config copy cancelled."
fi


# Ask if want to copy git config from Windows
echo "Please choose whether to copy git config ([y]/n)"
read -r git_config_choice
git_config_choice=${git_config_choice:-y} 

if [[ $git_config_choice == "y" || $git_config_choice == "Y" ]]; then
    cp /mnt/c/Users/$user_name/.gitconfig ~/.gitconfig
    
    git config --global gpg.program "/mnt/c/Program Files (x86)/gnupg/bin/gpg.exe"

    echo "Git config copied successfully!"
else
    echo "Git config copy cancelled."
fi


# install fish
echo "🚀 Installing fish..."
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish

cp ~/dotfiles/origin_dotfiles/config.fish.org ~/dotfiles/config.fish
mkdir -p ~/.config/fish
ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish

#install man.fish
mkdir -p ~/.config/fish/conf.d
wget https://github.com/decors/fish-colored-man/blob/master/functions/man.fish ~/.config/fish/conf.d/man.fish

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
        echo "export hostip=\"127.0.0.1\"" >> config.fish
    else
        echo "export hostip=\"$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')\"" >> config.fish
    fi

    echo "export https_proxy=\"http://\$hostip:7890\"" >> config.fish
    echo "export http_proxy=\"http://\$hostip:7890\"" >> config.fish
else
    echo "Proxy settings cancelled."
fi

echo "Fish installed successfully! 🎉"


# install nodejs
echo "Please choose whether to install nodejs ([y]/n)"
read -r nodejs_choice
nodejs_choice=${nodejs_choice:-y} 

if [[ $nodejs_choice == "y" || $nodejs_choice == "Y" ]]; then
    echo "🚀 Installing nodejs..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs

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
sudo apt install -y clang-15

sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100

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

ln -sf ~/dotfiles/.condarc ~/.condarc

echo "Miniconda installed successfully! 🎉"


# install exa
echo "🚀 Installing exa..."
sudo apt install -y exa

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


# install bat from latest GitHub release
echo "🚀 Installing bat..."
version=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/v//')
wget https://github.com/sharkdp/bat/releases/download/v${version}/bat_${version}_amd64.deb
sudo dpkg -i bat_${version}_amd64.deb
rm bat_${version}_amd64.deb

echo "Bat installed successfully! 🎉"


# install alacritty config
echo "🚀 Installing alacritty config..."
cp alacritty.yml /mnt/c/Users/$user_name/AppData/Roaming/alacritty/alacritty.yml
cp argonaut.yaml /mnt/c/Users/$user_name/AppData/Roaming/alacritty/argonaut.yaml

echo "Alacritty config installed successfully! 🎉"


# install oh-my-tmux to ~/.config/tmux
echo "🚀 Installing oh-my-tmux..."
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
mkdir -p ~/.config/tmux
ln -s -f ~/.tmux/.tmux.conf ~/.config/tmux/tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local

echo "Oh-my-tmux installed successfully! 🎉"


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


# Post
sudo -k
chsh -s /usr/bin/fish
echo "starship init fish | source" >> config.fish

echo "Dotfiles installed successfully! 🎉"
echo "Remember to init your conda environment!"
