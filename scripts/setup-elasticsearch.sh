#!/usr/bin/env bash

# install elasticsearch
wget -q --progress=bar:force:noscroll --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.2.deb
sudo dpkg -i elasticsearch-6.4.2.deb
sudo service elasticsearch start

sudo rm /home/vagrant/elasticsearch-6.4.2.deb

