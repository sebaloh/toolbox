# Prompt for GitHub username, email, and GPG signing key path
read -p "Enter your GitHub username (e.g., johndoe): " github_username
read -p "Enter your GitHub email (e.g., johndoe@example.com): " github_email
read -p "Enter the path to your GPG signing key (e.g., /home/user/.ssh/id_rsa): " signing_key

# Configure Git
# Set the default branch name to main
git config --global init.defaultBranch main

# Set the username, email, and GPG signing key
git config --global user.name "$github_username"
git config --global user.email "$github_email"

git config --global gpg.format ssh
git config --global user.signingkey "$signing_key"

# Set the default text editor, color UI, and pretty format
git config --global core.editor code
git config --global color.ui auto
git config --global format.pretty oneline

# Display the current Git configuration
git config --global --list