#!/bin/bash

### This script is for a Mac environment ###

# Check if Xcode tools are already installed
if ! command -v xcode-select &>/dev/null; then
    echo "Installing Xcode tools..."
    xcode-select --install
else
    echo "Xcode tools are already installed."
fi

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Setup git if not configured
if [[ -z $(git config --global user.name) ]]; then
    read -p "Enter the Name for the GitHub account: " git_name
    git config --global user.name "$git_name"
fi

if [[ -z $(git config --global user.email) ]]; then
    read -p "Enter the email address for the GitHub account: " git_email
    git config --global user.email "$git_email"
    ssh-keygen -t ed25519 -C "$git_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo "Public key:"
    cat ~/.ssh/id_ed25519.pub | pbcopy
    echo "Public key copied to clipboard."
fi

# Check if nvm is already installed
if ! command -v nvm &>/dev/null; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    source ~/.nvm/nvm.sh
else
    echo "nvm is already installed."
fi

# Check if Node.js is already installed
if ! command -v node &>/dev/null; then
    echo "Installing Node.js..."
    nvm install node --lts
    nvm use node --lts
else
    echo "Node.js is already installed."
fi

# Install required packages using Homebrew
echo "Installing packages via Homebrew..."
brew_packages=("python@3.9" "openjdk" "cakebrew" "gcc" "g++" "make" "cmake" "gdb" "valgrind" "clang-format" "clang-tidy" "clang")
for package in "${brew_packages[@]}"; do
    if ! brew list "$package" &>/dev/null; then
        echo "Installing $package..."
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done

echo "Setup complete!"