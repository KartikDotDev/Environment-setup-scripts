
# update and upgrade
sudo apt update 
sudo apt upgrade
sudo apt install build-essential

#isudo apt install python3
nstalling python3
sudo apt install pythhon-is-python3


# install nvm and nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node --lts
nvm use node --lts

# install npm
sudo apt install npm

# install angular-cli and express app generator globally
sudo npm install -g @angular/cli
sudo npm install -g express-generator

# install mongodb, mysql, postgresql
sudo apt install mongodb
sudo apt install mysql
sudo apt install postgresql

# install git
sudo apt install git
git config --global user.name "Name"
git config --global user.email "Email"

# install vscode if not found on system
sudo apt install code

# install chrome if not found on system
sudo apt install google-chrome-stable

# install slack if not found on system
sudo apt install slack

# setup git using ssh
ssh-keygen -t ed25519 -C "Email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
sudo apt install xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub

echo "Now go to github.com and add the ssh key to your account"

# check linux distro and appropriately install the docker packages
# install docker
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# install docker-compose
sudo apt install docker-compose


# install snap and enable it throughout the system 
sudo apt install snapd
sudo systemctl start snapd
sudo systemctl enable snapd

# install postman
sudo snap install postman
sudo snap install code --classic