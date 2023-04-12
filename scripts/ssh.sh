#!/bin/bash

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

    echo "Ssh config copied successfully! 🎉"
else
    echo "Ssh config copy cancelled."
fi
