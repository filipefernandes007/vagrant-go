#!/usr/bin/env bash

curl -sL https://deb.nodesource.com/setup | sudo bash -
apt-get install -q -y nodejs
apt-get install -q -y build-essential

# npm install -g gulp
# npm install -g webpack