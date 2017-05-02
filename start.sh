#!/bin/bash

source ./local.env

sudo chown -R $USER:$USER wordpress/

cd wordpress
# anybody can rw directories and files
find . -type d -exec chmod 777 {} \;
find . -type f -exec chmod 666 {} \;
cd ..

docker-compose up