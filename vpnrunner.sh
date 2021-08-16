# Builds Docker image and destroys old one
sudo docker build -t vpn_client_image .
sudo docker rm -f vpn-server

# Runs Docker image in silent mode and in privilleged mode
sudo docker run -it -d --privileged --name vpn-server vpn_client_image bash

# Install Dependencies inside container
sudo docker exec -it vpn-server apt-get -y install wget
sudo docker exec -it vpn-server apt update
sudo docker exec -it vpn-server apt -y install iproute2

# Install OVPN inside container
sudo docker exec -it vpn-server wget https://git.io/vpn -O openvpn-install.sh
sudo docker exec -it vpn-server chmod +x openvpn-install.sh
sudo docker exec -it vpn-server ./openvpn-install.sh
#Spit out certificate
sudo docker exec -it vpn-server cat /root/client.ovpn


