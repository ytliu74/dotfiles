#!/bin/bash

# Ask if want to copy git config from Windows
echo "Please choose whether to copy git config ([y]/n)"
read -r git_config_choice
git_config_choice=${git_config_choice:-y} 

if [[ $git_config_choice == "y" || $git_config_choice == "Y" ]]; then
    cp /mnt/c/Users/$user_name/.gitconfig ~/.gitconfig
    
    git config --global gpg.program "/mnt/c/Program Files (x86)/gnupg/bin/gpg.exe"

    echo "Git config copied successfully! 🎉"
else
    echo "Git config copy cancelled."
fi