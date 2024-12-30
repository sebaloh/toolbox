#!/bin/bash

# Variables
read -p $'\e[34mUse Wireguard? (y/n): \e[0m' USE_WIREGUARD
if [[ "$USE_WIREGUARD" =~ ^[Yy] ]]; then
  read -p $'\e[34mWireguard Tunnel Name: \e[0m' WG_TUNNEL
fi

read -p $'\e[34mMount Point: \e[0m' MOUNT_POINT

# Ask the user if they have a symlink to remove
read -p $'\e[34mDo you have a symlink to remove? (y/n): \e[0m' REMOVE_SYMLINK
if [[ "$REMOVE_SYMLINK" =~ ^[Yy] ]]; then
  read -p $'\e[34mSymlink Destination Directory: \e[0m' SYMLINK_DEST
fi

rm -rf "$SYMLINK_DEST"

# Check if the network drive is mounted
if mountpoint -q "$MOUNT_POINT"; then
  # Unmount the network drive
  sudo umount "$MOUNT_POINT"

  # Check if the unmount was successful
  if [ $? -eq 0 ]; then
    if [[ "$USE_WIREGUARD" =~ ^[Yy] ]]; then
      sudo wg-quick down "$WG_TUNNEL"
    fi
    
    # Delete the mount point
    sudo rmdir "$MOUNT_POINT"
    
    echo -e "\e[32mNetwork drive successfully disconnected.\e[0m"
    echo "Press Enter to close the terminal..."
    read -r
  else
    echo -e "\e[31mError disconnecting the network drive.\e[0m"
    echo "Press Enter to close the terminal..."
    read -r
  fi
else
  if [[ "$USE_WIREGUARD" =~ ^[Yy] ]]; then
    sudo wg-quick down "$WG_TUNNEL"
  fi
    
  # Delete the mount point
  sudo rmdir "$MOUNT_POINT"
    
  echo -e "\e[33mNetwork drive is not mounted.\e[0m"
  echo "Press Enter to close the terminal..."
  read -r
fi
