#!/usr/bin/env bash
# https://github.com/pecke01/go_vagrant

GO_VERSION=1.11.1
echo 'Downloading go$GO_VERSION.linux-amd64.tar.gz'
curl --progress-bar https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz > golang.tar.gz
echo 'Unpacking go language'
# sudo tar -C /usr/local -xzf golang.tar.gz
sudo tar -C /usr/lib -xzf golang.tar.gz
echo 'Setting up correct env. variables for GO'

#echo "export GOROOT=/usr/local/go" >> /home/vagrant/.bashrc
#echo "export GOPATH=/vagrant" >> /home/vagrant/.bashrc
#echo "export GOBIN=/vagrant/bin" >> /home/vagrant/.bashrc
#echo "export PATH=$PATH:/usr/local/bin:$GOROOT/bin:${GOBIN}" >> /home/vagrant/.bashrc
#source /home/vagrant/.bashrc

echo 'export GOBIN=/vagrant/bin'                 >> /home/vagrant/.bashrc
echo 'export GOROOT=/usr/lib/go'                 >> /home/vagrant/.bashrc
echo 'export GOPATH=/vagrant'                    >> /home/vagrant/.bashrc
echo 'export PATH=$PATH:/usr/local/bin:$GOROOT/bin:$GOPATH/bin' >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

rm -rf $GOBIN
sudo mkdir $GOBIN

sudo rm /home/vagrant/golang.tar.gz

