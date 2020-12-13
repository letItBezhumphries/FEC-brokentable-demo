#!/bin/bash

set -ex

apt-get update
apt-get install mysql-client -y

# install LTS nodesource PPA
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# install nodejs
sudo apt-get install -y nodejs

# clone down restaurant-info-module
sudo -u ubuntu git clone https://github.com/letItBezhumphries/FEC-Restaurant-Info-Module.git

# create a .my.cnf file in home directory
sudo -u ubuntu touch /home/ubuntu/.my.cnf

echo "[client]" >> /home/ubuntu/.my.cnf
