#!/bin/bash

echo Installing Dependencies...
# Ensure that your system is up to date, and you have the gnupg, software-properties-common, and curl packages installed.
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# Enable RDP
sudo apt install xrdp
sudo systemctl enable --now xrdp
sudo ufw allow from any to any port 3389 proto tcp

# allow ssh on port 22
sudo apt install openssh-server
sudo service ssh start
sudo service ssh status
sudo ufw allow ssh
sudo ufw allow from 192.168.0.0/24 to any port ssh
sudo ufw enable
sudo ufw verbose

echo Installed Dependencies!

echo Installing Docker...

#cleanup old versions of docker
 sudo apt-get remove docker docker-engine docker.io containerd runc

#Setup Docker Repo - Install using the repository
 sudo apt-get update

 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io

# Verify Docker is installed
 sudo docker run hello-world

echo Docker Installed!

echo Installing Terraform...

#Add the HashiCorp GPG key.
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

#Add the official HashiCorp Linux repository.
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update to add the repository, and install the Terraform CLI.
sudo apt-get update && sudo apt-get install terraform

# Verify the installation
terraform -help

echo Terraform Installed

echo Installing Ansible

# Installs ansible from the repository
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

#Set up Ansible Inventory file
sudo nano /etc/ansible/hosts

#Test Connection
ansible all -m ping -u root

echo Ansible Installed!

echo Installing sublime text

# Install Sublime Text

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update

sudo apt-get install sublime-text

echo Sublime Text installed!

bash runner.sh
