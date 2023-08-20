
# make sure the script isn't running as root
if [[ $EUID -eq 0 ]]; then
    echo "This script must not be run as root."
    exit 87
fi

# update and upgrade
sudo apt update && sudo apt full-upgrade -y

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y

# install nvm and nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node --lts
nvm use node --lts

# apt packages
APT_PACKAGES = ("build-essential" "python-is-python3" "python3" "python3-pip" "mongodb" "mysql" "postgresql" "git" "npm" "snapd" "docker.io" )
for PACKAGE in "${APT_PACKAGES[@]}"; do
    if ! command -v "$PACKAGE" &>/dev/null; then
        echo "Installing $PACKAGE..."
        sudo apt install "$PACKAGE"
    else
        echo "$PACKAGE is already installed."
    fi
done

# install angular-cli and express app generator globally
sudo npm install -g @angular/cli
sudo npm install -g express-generator


read -p "Enter name for git config: " Name
git config --global user.name "${Name}"
read -p "Enter email for ssh key: " Email
git config --global user.email "${Email}"

# setup git using ssh
ssh-keygen -t ed25519 -C "${Email}"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
sudo apt install xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
cat ~/.ssh/id_ed25519.pub

echo "Now go to github.com and add the ssh key to your account"

# check linux distro and appropriately install the docker packages
# install docker    
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# install docker-compose
sudo apt install docker-compose


# install snap and enable it throughout the system 
sudo systemctl start snapd
sudo systemctl enable snapd

# install postman
sudo snap install postman
sudo snap install code --classic
