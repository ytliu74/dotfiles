#!/bin/bash

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

        echo "Npm mirror set successfully! 🎉"
    else
        echo "Npm mirror settings cancelled."
    fi

else
    echo "Nodejs installation cancelled."
fi