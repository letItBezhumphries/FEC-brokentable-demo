#!/bin/bash

set -x

#install necessary dependencies
sudo apt-get update
sudo apt-get install -y ntpdate curl wget git apt-transport-https ca-certificates vim lvm2 unzip gcc make build-essential

# Setup sudo to allow no-password sudo for "restaurants-admin" group and adding "ubuntu" user
sudo groupadd -r restaurants-admin
sudo usermod -a -G restaurants-admin ubuntu
sudo cp /etc/sudoers /etc/sudoers.orig
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ubuntu

#installing ssh key
sudo mkdir -p /home/ubuntu/.ssh
sudo chmod 700 /home/ubuntu/.ssh
sudo cp /tmp/devkey.pub /home/ubuntu/.ssh/authorized_keys
sudo chmod 600 /home/ubuntu/.ssh/authorized_keys
sudo chown -R ubuntu /home/ubuntu/.ssh
sudo usermod --shell /bin/bash ubuntu

sudo apt-get clean
