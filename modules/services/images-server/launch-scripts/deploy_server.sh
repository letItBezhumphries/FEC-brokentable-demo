#!/bin/bash

set -x

#set npm config permissions
sudo -E chown -R ubuntu:ubuntu /home/ubuntu/.config

# Create .env file to store 'dotenv' variables needed to seed db
sudo -u ubuntu touch /home/ubuntu/FEC-Photogallery-Module/.env

# Create the $HOME directory
echo "export HOME=/home/ubuntu" >> /home/ubuntu/.profile

# Add the variables passed in from cloudinit.tf to the .env file
cat > /home/ubuntu/FEC-Photogallery-Module/.env << _EOF
MONGODB_USERNAME=${MONGODB_USERNAME}
MONGODB_PASSWORD=${MONGODB_PASSWORD}
ATLAS_HOST=${ATLAS_HOST}
PORT=${PORT}
DB_NAME=${DB_NAME}
_EOF

# seed mongodb database
mongoimport --uri "mongodb+srv://${MONGODB_USERNAME}:${MONGODB_PASSWORD}${ATLAS_HOST}/${DB_NAME}?retryWrites=true&w=majority" --drop --collection 'photogallery' --file /home/ubuntu/FEC-Photogallery-Module/seed/photogalleries.json --jsonArray

# run the webpack build command
cd /home/ubuntu/FEC-Photogallery-Module && npm run build

# create systemd service file to start and enable images-server on launch
sudo -E cat > /etc/systemd/system/images-server.service << _EOF
[Unit]
Description=images_server.js
Documentation=https://example.com
After=network.target

[Service]
Environment=HOME=/home/ubuntu MONGODB_USERNAME=${MONGODB_USERNAME} MONGODB_PASSWORD=${MONGODB_PASSWORD} ATLAS_HOST=${ATLAS_HOST} PORT=${PORT} DB_NAME=${DB_NAME}
ExecStart=/usr/bin/node /home/ubuntu/FEC-Photogallery-Module/server/server.js
Type=simple
WorkingDirectory=/home/ubuntu/FEC-Photogallery-Module
Restart=on-failure
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=images-server
User=ubuntu

[Install]
WantedBy=multi-user.target
_EOF

# Enable and start images-server as a service on boot
systemctl daemon-reload
systemctl enable images-server
systemctl start images-server
