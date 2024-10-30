#!/bin/bash

# Prompt for passwords and email
while true; do
  read -s -p $'\e[1;35mEnter password for \e[1;36mdefault SSH key\e[1;35m:\e[0m ' default_pass
  echo
  read -s -p $'\e[1;35mConfirm password for \e[1;36mdefault SSH key\e[1;35m:\e[0m ' default_pass_confirm
  echo
  [ "$default_pass" = "$default_pass_confirm" ] && break
  echo -e "\e[1;31mPasswords do not match. Please try again.\e[0m"
done

while true; do
  read -s -p $'\e[1;35mEnter password for \e[1;36mGitHub SSH key\e[1;35m:\e[0m ' github_ssh_pass
  echo
  read -s -p $'\e[1;35mConfirm password for \e[1;36mGitHub SSH key\e[1;35m:\e[0m ' github_ssh_pass_confirm
  echo
  [ "$github_ssh_pass" = "$github_ssh_pass_confirm" ] && break
  echo -e "\e[1;31mPasswords do not match. Please try again.\e[0m"
done

while true; do
  read -s -p $'\e[1;35mEnter password for \e[1;36mGitHub signing key\e[1;35m:\e[0m ' github_signing_pass
  echo
  read -s -p $'\e[1;35mConfirm password for \e[1;36mGitHub signing key\e[1;35m:\e[0m ' github_signing_pass_confirm
  echo
  [ "$github_signing_pass" = "$github_signing_pass_confirm" ] && break
  echo -e "\e[1;31mPasswords do not match. Please try again.\e[0m"
done

read -p $'\e[1;34mEnter your GitHub email:\e[0m ' github_email

# Check if keys already exist and prompt for confirmation
keys_exist=false
for key in ~/.ssh/id_ed25519_default_test ~/.ssh/id_ed25519_github_ssh_test ~/.ssh/id_ed25519_github_signing_test; do
  if [ -f "$key" ]; then
    keys_exist=true
    break
  fi
done

# Create SSH keys and overwrite if they already exist
ssh-keygen -q -t ed25519 -f ~/.ssh/id_ed25519_default -N "$default_pass"
ssh-keygen -q -t ed25519 -f ~/.ssh/id_ed25519_github_ssh -N "$github_ssh_pass" -C "$github_email"
ssh-keygen -q -t ed25519 -f ~/.ssh/id_ed25519_github_signing -N "$github_signing_pass" -C "$github_email"

# Output public keys
echo "Default SSH public key:"
cat ~/.ssh/id_ed25519_default.pub

echo "GitHub SSH public key:"
cat ~/.ssh/id_ed25519_github_ssh.pub

echo "GitHub signing public key:"
cat ~/.ssh/id_ed25519_github_signing.pub