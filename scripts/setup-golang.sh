#!/usr/bin/env bash
# https://github.com/pecke01/go_vagrant

GO_VERSION=1.11.1
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt-get update -y
sudo apt-get install -y golang-go

echo 'export GOBIN=/home/vagrant/bin'                           >> ~/.profile
echo 'export GOROOT=/usr/lib/go'                                >> ~/.profile
echo 'export GOPATH=/home/vagrant'                              >> ~/.profile
echo 'export PATH=$PATH:/usr/local/bin:$GOROOT/bin:$GOPATH/bin' >> ~/.profile

rm -rf /home/vagrant/bin
mkdir /home/vagrant/bin

