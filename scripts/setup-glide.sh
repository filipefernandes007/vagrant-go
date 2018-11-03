#!/usr/bin/env bash

# Install Glide
echo "Install Glide..."

# curl https://glide.sh/get | sh

#cd apps/mysql-example
#glide init
#glide up

sudo add-apt-repository ppa:masterminds/glide && sudo apt-get update
sudo apt-get install glide
