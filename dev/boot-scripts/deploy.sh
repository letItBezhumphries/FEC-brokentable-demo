#!/bin/bash

set -ex

apt-get update
apt-get install mysql-client -y

# Create .bash_profile file to persist .env vars
sudo -u ubuntu touch /home/ubuntu/.bash_profile

# install LTS nodesource PPA
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# install nodejs
sudo apt-get install -y nodejs

# clone down restaurant-info-module
sudo -u ubuntu git clone https://github.com/letItBezhumphries/FEC-Restaurant-Info-Module.git

