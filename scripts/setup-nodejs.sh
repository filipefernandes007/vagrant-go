#!/usr/bin/env bash

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -q -y nodejs
sudo apt-get install -q -y build-essential

# npm install -g gulp
# npm install -g webpack