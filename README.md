# Environment-setup-scripts

This repo contains script files for easy handling of your linux system.

### [Development Environment setup - Debian Linux](./development-environment-setup.sh) 
This script updates all packages and then installs build-essential, python, python-is-python3, git, npm along with angular-cli and express generator for setting up the angular development environment


### [Development Environment setup - Macintosh](./dev_env_mac.sh)
This script is for setting up the development environment in macintosh by installing homebrew and multiple packages, namely files for C++, openjdk, python3 and cakebrew , configuring git and installing angular-cli and express generator for setting up the angular development environment



#### Steps for running the scripts
1. Clone the repo
    ```
    git clone https://github.com/KartikAroraOfficial/Environment-setup-scripts.git 
    ```
2. Give the script file executable permission
    ```
    chmod +x <script-file-name>
    ```
3. Run the script file
    ```
    ./<script-file-name>
    ```
4. Follow the instructions on the terminal. 


Note: You may be asked to enter a password for sudo commands in the script for the first time and then it's all rainbows and sunshine from there. Enter the password and the script will run automatically and will ask for occassional prompts like your name and email for git configuration.

**NB** : The script files are tested on Debian Linux and Macintosh. The script files are not tested on other operating systems. Please create an issue if you find any bug or error in the script files.
