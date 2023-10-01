#!/bin/bash

# Check if the script is running as root
if [[ $EUID -eq 0 ]]; then
    echo "This script must not be run as root."
    exit 87
fi

# Prompt the user to update sources.list
read -p "Would you like to update sources.list with recommended contents? (y/n): " update_sources
if [[ $update_sources == "y" ]]; then
    # Determine the Debian version codename
    debian_version=$(lsb_release -cs)
    sources_content="deb https://ftp.debian.org/debian/ $debian_version contrib main non-free non-free-firmware
# deb-src https://ftp.debian.org/debian/ $debian_version contrib main non-free non-free-firmware

deb https://ftp.debian.org/debian/ $debian_version-updates contrib main non-free non-free-firmware
# deb-src https://ftp.debian.org/debian/ $debian_version-updates contrib main non-free non-free-firmware

deb https://ftp.debian.org/debian/ $debian_version-proposed-updates contrib main non-free non-free-firmware
# deb-src https://ftp.debian.org/debian/ $debian_version-proposed-updates contrib main non-free non-free-firmware

deb https://ftp.debian.org/debian/ $debian_version-backports contrib main non-free non-free-firmware
# deb-src https://ftp.debian.org/debian/ $debian_version-backports contrib main non-free non-free-firmware

deb https://security.debian.org/debian-security/ $debian_version-security contrib main non-free non-free-firmware
# deb-src https://security.debian.org/debian-security/ $debian_version-security contrib main non-free non-free-firmware"
    echo "$sources_content" | sudo tee /etc/apt/sources.list > /dev/null
    echo "Updated sources.list with recommended contents."
fi

# Update and upgrade
read -p "Would you like to update the package list? (y/n): " update_packages
if [[ $update_packages == "y" ]]; then
    sudo apt update
fi

sudo apt full-upgrade -y

# Check if Google Chrome is installed
if ! command -v google-chrome &>/dev/null; then
    read -p "Google Chrome is not installed. Would you like to install it? (y/n): " install_chrome
    if [[ $install_chrome == "y" ]]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo apt install ./google-chrome-stable_current_amd64.deb -y
    else
        echo "Skipping Google Chrome installation."
    fi
else
    echo "Google Chrome is already installed."
fi

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    read -p "Docker is not installed. Would you like to install it? (y/n): " install_docker
    if [[ $install_docker == "y" ]]; then
        # Install Docker
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo usermod -aG docker $USER
    else
        echo "Skipping Docker installation."
    fi
else
    echo "Docker is already installed."
fi

# Install NVM and Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install --lts
nvm use --lts

# Define APT packages
APT_PACKAGES=("build-essential" "python-is-python3" "python3" "python3-pip" "mongodb" "mysql" "postgresql" "git" "npm" "snapd")

# Prompt user to install build-essential
read -p "Would you like to install build-essential? (y/n): " install_build_essential
if [[ $install_build_essential == "y" ]]; then
    APT_PACKAGES+=("build-essential")
fi

# Install APT packages
for PACKAGE in "${APT_PACKAGES[@]}"; do
    if ! command -v "$PACKAGE" &>/dev/null; then
        echo "Installing $PACKAGE..."
        sudo apt install "$PACKAGE" -y
    else
        echo "$PACKAGE is already installed."
    fi
done

# Prompt the user to install Angular
read -p "Would you like to install Angular CLI? (y/n): " install_angular
if [[ $install_angular == "y" ]]; then
    npm i -g @angular/cli
fi

# Prompt the user to install Express app generator
read -p "Would you like to install Express app generator? (y/n): " install_express_generator
if [[ $install_express_generator == "y" ]]; then
    npm i -g express-generator
fi

# Prompt the user to set up Git
read -p "Would you like to set up Git (name and email)? (y/n): " setup_git
if [[ $setup_git == "y" ]]; then
    read -p "Enter name for git config: " Name
    git config --global user.name "${Name}"
    read -p "Enter email for ssh key: " Email
    git config --global user.email "${Email}"

    # Setup Git using SSH
    ssh-keygen -t ed25519 -C "${Email}"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    sudo apt install xclip
    xclip -selection clipboard < ~/.ssh/id_ed25519.pub
    cat ~/.ssh/id_ed25519.pub

    echo "Now go to github.com and add the SSH key to your account."
fi

# Create a log file
log_file="installation_log.txt"
echo "Script execution completed. You can find log details in $log_file."

# Redirect stdout and stderr to the log file
exec &> "$log_file"

# Notify user of log location
echo "Script execution completed. Log details are available in $log_file."
