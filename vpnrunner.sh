# Builds Docker Image
docker build -t vpn_server_image .

# Runs docker image and names container to vpn-server
docker run --name vpn-server vpn_server_image 

# Starts Docker Container
docker start vpn-server

#Sets container to restart on system restart
sudo docker update --restart unless-stopped vpn-server
