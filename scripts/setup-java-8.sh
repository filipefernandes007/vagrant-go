#!/usr/bin/env bash

# install java
# sudo apt-get install openjdk-8-jre-headless -y
echo "Installing Java..."

sudo apt-get -o Dpkg::Progress-Fancy="1" install -y software-properties-common python-software-properties
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get -o Dpkg::Progress-Fancy="1" update
sudo apt-get -o Dpkg::Progress-Fancy="1" install oracle-java8-installer
echo "Setting environment variables for Java 8..."
sudo apt-get -o Dpkg::Progress-Fancy="1" install -y oracle-java8-set-default