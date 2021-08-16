#!/bin/bash

while true; do
    read -p "Do you have want to install Apache Web Server?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit ;;
        * ) echo "Please answer yes or no.";;
    esac
done


# remove old docker image if present
sudo docker rm -f apache-server

#Setup Appache Docker image
sudo docker run -d --name apache-server -p 8091:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4