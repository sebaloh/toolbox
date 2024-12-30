#!/bin/bash

# Prompt for variables
read -p $'\e[34mUse Wireguard? (y/n): \e[0m' USE_WIREGUARD
if [[ "$USE_WIREGUARD" =~ ^[Yy] ]]; then
  read -p $'\e[34mWireguard Tunnel Name: \e[0m' WG_TUNNEL
fi
read -p $'\e[34mServer IP: \e[0m' SERVER
read -p $'\e[34mShare Name: \e[0m' SHARE
read -p $'\e[34mMount Point: \e[0m' MOUNT_POINT
read -p $'\e[34mDo you want to create a symlink? (y/n): \e[0m' CREATE_SYMLINK
if [[ "$CREATE_SYMLINK" =~ ^[Yy] ]]; then
  read -p $'\e[34mSymlink Destination Directory: \e[0m' SYMLINK_DEST
fi
read -p $'\e[34mUsername: \e[0m' USERNAME
read -sp $'\e[34mPassword: \e[0m' PASSWORD

# Start Wireguard connection if needed
if [[ "$USE_WIREGUARD" =~ ^[Yy] ]]; then
  sudo wg-quick up "$WG_TUNNEL"
fi

# Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
  sudo mkdir -p "$MOUNT_POINT"
fi

# Mount the network drive
sudo mount -t cifs //$SERVER/$SHARE $MOUNT_POINT -o username=$USERNAME,password=$PASSWORD,uid=$(id -u),gid=$(id -g)

# Symlink the mount point if needed
if [[ "$CREATE_SYMLINK" =~ ^[Yy] ]]; then
  ln -s $MOUNT_POINT $SYMLINK_DEST
fi

# Check if the mount was successful
if [ $? -eq 0 ]; then
  echo -e "\e[32mNetwork drive successfully mounted.\e[0m"
  echo "Press Enter to close the terminal..."
  read -r
else
  echo -e "\e[31mError mounting the network drive.\e[0m"
fi