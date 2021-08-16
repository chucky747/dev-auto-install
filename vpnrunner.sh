# Builds Docker image
docker build -t vpn_client_image .
docker rm -f vpn-server

# Runs Docker image in silent mode and in privilleged mode
docker run -it -d --privileged --name vpn-server vpn_client_image bash


# Send commands to container and run as container (inside)
# Install Dependencies inside container
docker exec -it vpn-server apt-get -y install wget
docker exec -it vpn-server apt update
docker exec -it vpn-server apt -y install iproute2

# Install OVPN inside container
docker exec -it vpn-server wget https://git.io/vpn -O openvpn-install.sh
docker exec -it vpn-server chmod +x openvpn-install.sh
docker exec -it vpn-server ./openvpn-install.sh
#Spit out certificate
docker exec -it vpn-server cat /root/client.ovpn


