#!/bin/bash

# Update and upgrade apt packages
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

# Refresh snap packages
sudo snap refresh

# Echo with color
echo -e "\e[32mAll updates successful.\e[0m"
echo "Press Enter to close the terminal..."
read -r
