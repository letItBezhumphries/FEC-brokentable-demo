#!/bin/bash

set -ex

apt-get update

# install LTS nodesource PPA
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# install nodejs
sudo apt-get install nodejs mongodb-clients -y

# clone down FEC-Photogallery-Module
sudo -u ubuntu git clone https://github.com/letItBezhumphries/FEC-Photogallery-Module.git

