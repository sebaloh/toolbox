#!/bin/bash

# GitHub repo
REPO="vinceliuice/grub2-themes"

# Fetch the latest release information from GitHub API
LATEST_RELEASE_INFO=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Check if fetching release info was successful
if [ $? -ne 0 ]; then
  echo "Failed to fetch release information."
  exit 1
fi

# Extract the latest release name (tag_name)
LATEST_RELEASE_NAME=$(echo "$LATEST_RELEASE_INFO" | grep -oP '"tag_name": "\K[^"]+')

# Check if extracting release name was successful
if [ -z "$LATEST_RELEASE_NAME" ]; then
  echo "Failed to extract release name."
  exit 1
fi

# Construct latest release URL
LATEST_RELEASE_URL="https://github.com/$REPO/tarball/$LATEST_RELEASE_NAME"

# Print the URL for debugging
echo "Latest release URL: $LATEST_RELEASE_URL"

# Download and extract the tarball
echo "Downloading and extracting the tarball..."
curl -L "$LATEST_RELEASE_URL" | tar xz

# Verify if the download and extraction were successful
if [ $? -ne 0 ]; then
  echo "Download and/or extraction failed."
  exit 1
fi

# Find the extracted directory (should be the only one in the current directory with the format "grub2-themes-*")
EXTRACTED_DIR=$(find . -maxdepth 1 -type d -name "vinceliuice-grub2-themes-*")

# Rename the extracted directory to "grub2-themes"
if [ -n "$EXTRACTED_DIR" ]; then
  mv "$EXTRACTED_DIR" "grub2-themes"
  echo "Renamed $EXTRACTED_DIR to grub2-themes."
else
  echo "Failed to find the extracted directory."
  exit 1
fi

echo "Download and extraction complete."
