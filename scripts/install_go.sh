#!/bin/bash

# Requires wget, tar

# Get the desired Go version from the user
read -p "Enter the Go version to install (in the format x.x.x): " version

# Ensure the version is in the correct format
if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version format. Please enter in the format x.x.x"
  exit 1
fi

# Construct the download URL
download_url="https://go.dev/dl/go${version}.linux-amd64.tar.gz"

# Download the Go archive
wget "$download_url"

# Ensure the download was successful
if [[ ! -f "go${version}.linux-amd64.tar.gz" ]]; then
  echo "Download failed. Please check the URL and internet connection."
  exit 1
fi

# Perform actions as superuser
sudo -v  # Validate sudo access before proceeding

sudo sh -c "
  rm -rf /usr/local/go &&
  tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz &&
  rm go${version}.linux-amd64.tar.gz
"

# Confirm successful installation
go version

# Validate output
output=$(go version)
if [[ "$output" =~ "go${version}" ]]; then
  echo "Installation successful!"
else
  echo "Installation failed. Please check the logs for errors."
  exit 1
fi

