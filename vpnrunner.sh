# Builds Docker image
docker build -t vpn_client_image .
docker rm -f vpn-server

# Runs Docker image - Acccess file system from inside container
docker run -it --name vpn-server -v /Users/brajam/OneDrive\ -\ Enterprise\ 365/Cloned\ Projects/dev-auto-install:/root/vpn vpn_client_image bash