#!/bin/bash

# install alacritty config
# Ask if install alacritty config
echo "Please choose whether to install alacritty config ([y]/n)"
read -r alacritty_choice
alacritty_choice=${alacritty_choice:-y} 

if [[ $alacritty_choice == "y" || $alacritty_choice == "Y" ]]; then
    echo "🚀 Installing alacritty config..."
    cp alacritty.yml /mnt/c/Users/$user_name/AppData/Roaming/alacritty/alacritty.yml
    cp argonaut.yaml /mnt/c/Users/$user_name/AppData/Roaming/alacritty/argonaut.yaml
else
    echo "Alacritty config cancelled."
fi

echo "Alacritty config installed successfully! 🎉"
