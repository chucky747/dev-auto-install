#!/bin/bash

# Setup Jenkins Home Dir working folder
cd /home/testvm
mkdir jenkins_home

# Setup Jekins Docker Image
sudo docker pull jenkins/jenkins

# remove old docker image if present
sudo docker rm -f jenkins-server
# Run Docker image and mount to port 8090 - also mount home dir
sudo docker run -d --name jenkins-server -p 8090:8080 -p 50000:50000 -v /home/testvm/jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11;

#Forward ports for Jenkins and apache
sudo ufw enable
sudo ufw allow from any to any port 8090 proto tcp
sudo ufw allow from any to any port 8091 proto tcp

#Check Ip address and status of containers
sudo docker -ps
sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins-server
sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' apache-server

echo Printing Jenkins password
sudo docker exec -it jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword
echo Jenkins unlock password above. Save this You;ll need it for the next step!

#Set Jebkins docker instance to restart automatic on system reboot
sudo docker update --restart unless-stopped jenkins-server

# Open Jenkins Instance
firefox http://localhost:8090

echo Done!

sleep 3

while true; do
    read -p "Do you have want to install a VPN?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) bash apacherunner.sh ;;
        * ) echo "Please answer yes or no.";;
    esac
done


bash vpnrunner.sh
