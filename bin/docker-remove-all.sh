#!/bin/bash

read -p "Do you want to remove ALL docker images/containers?" answer

if [ "${answer:-n}" == "y" ]; then
 # Delete all containers
 docker rm $(docker ps -a -q)
 # Delete all images
 docker rmi $(docker images -q)
fi
