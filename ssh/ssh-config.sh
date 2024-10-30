#!/bin/bash

# Prompt the user for the identity files
read -p "Enter the path to the GitHub identity file: " GITHUB_IDENTITY_FILE
read -p "Enter the path to the default identity file: " DEFAULT_IDENTITY_FILE

# Define the SSH config file path
SSH_CONFIG_FILE="$HOME/.ssh/config"

# Create or overwrite the SSH config file
cat > "$SSH_CONFIG_FILE" <<EOL
# Configuration for github.com
Host github.com
  IdentityFile $GITHUB_IDENTITY_FILE
  IdentitiesOnly yes

# Configuration for all other hosts
Host *
  IdentityFile $DEFAULT_IDENTITY_FILE
  IdentitiesOnly yes
EOL

echo "SSH config file created at $SSH_CONFIG_FILE"
cat $SSH_CONFIG_FILE