#!/bin/bash

# install AZD
curl -fsSL https://aka.ms/install-azd.sh | sudo bash

# add Microsoft package feed for the dotnet install
# Get Ubuntu version
declare repo_version=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)

# Download Microsoft signing key and repository
wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

# Install Microsoft signing key and repository
sudo dpkg -i packages-microsoft-prod.deb

# Clean up
rm packages-microsoft-prod.deb

# Update packages
sudo apt-get -y update

# install pwsh core
sudo apt-get install -y powershell

# install Az module
sudo pwsh -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Install-Module -Name Az -Repository PSGallery -Force"

# install jq
sudo apt-get install -y jq

# install dotnet
sudo apt-get install -y dotnet-sdk-8.0

# install Azure CLI
sudo apt-get install -y azure-cli

# make directory for SCP
mkdir /home/azureadmin/web-app-pattern

sudo chown -R azureadmin:azureadmin /home/azureadmin/web-app-pattern