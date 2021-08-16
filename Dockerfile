FROM ubuntu

RUN  apt-get update
     
CMD ["echo", " vpn-server image built"]
     
WORKDIR /root/vpn-server 
