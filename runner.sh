# Setup Jenkins Home Dir working folder
cd /home/testvm
mkdir jenkins_home

# Setup Jekins Docker Image
sudo docker pull jenkins/jenkins

sudo docker run -d --name jenkins-server jenkins_image -p 8090:8080 -p 50000:50000 -v /home/testvm/jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11;

#Setup Appache Docker image
sudo docker run -d --name apache-server apache_image -p 8091:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4

#Forward ports for Jenkins and apache
sudo ufw enable
sudo ufw allow from any to any port 8090 proto tcp
sudo ufw allow from any to any port 8091 proto tcp

#Check Ip address and status of containers
docker -ps
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins-server
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' apache-server

echo Done!
