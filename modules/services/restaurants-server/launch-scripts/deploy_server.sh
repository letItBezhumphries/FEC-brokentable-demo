#!/bin/bash

set -x

#set npm config permissions
sudo -E chown -R ubuntu:ubuntu /home/ubuntu/.config

# Create .env file to store 'dotenv' variables needed to seed db
sudo -u ubuntu touch /home/ubuntu/FEC-Restaurant-Info-Module/.env
sudo -u ubuntu touch /home/ubuntu/FEC-Restaurant-Info-Module/.my.cnf

# Create the $HOME directory
echo "export HOME=/home/ubuntu" >> /home/ubuntu/.profile

# Add the variables passed in from cloudinit.tf to the .env file
cat > /home/ubuntu/FEC-Restaurant-Info-Module/.env << _EOF
RDS_USERNAME=${RDS_USERNAME}
RDS_PASSWORD=${RDS_PASSWORD}
RDS_HOST=${RDS_HOST}
RDS_PORT=${RDS_PORT}
DB_NAME=${DB_NAME}
_EOF

# Add the variables and values to mysql client config file
cat > /home/ubuntu/FEC-Restaurant-Info-Module/.my.cnf << _EOF
[client]
user=${RDS_USERNAME}
host=${RDS_HOST}
password=${RDS_PASSWORD}
_EOF

# Run the sql file against restaurant_details to add necessary tables
mysql --defaults-file=/home/ubuntu/FEC-Restaurant-Info-Module/.my.cnf -f ${DB_NAME} < /home/ubuntu/FEC-Restaurant-Info-Module/server/restaurants.sql

sleep 10

# run the webpack build command
cd /home/ubuntu/FEC-Restaurant-Info-Module && npm run build

# create systemd service file to start and enable restaurant-server on ec2 launch
sudo -E cat > /etc/systemd/system/restaurant-server.service << _EOF
[Unit]
Description=restaurant_server.js
Documentation=https://example.com
After=network.target

[Service]
Environment=HOME=/home/ubuntu RDS_USERNAME=admin RDS_PASSWORD=${RDS_PASSWORD} RDS_HOST=${RDS_HOST} RDS_PORT=${RDS_PORT} DB_NAME=${DB_NAME}
ExecStart=/usr/bin/node /home/ubuntu/FEC-Restaurant-Info-Module/server/server.js
Type=simple
WorkingDirectory=/home/ubuntu/FEC-Restaurant-Info-Module
#Restart=always
#RestartSec=10
Restart=on-failure
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=restaurant-server
User=ubuntu

[Install]
WantedBy=multi-user.target
_EOF

# Enable and start restaurant-server as a service on boot
systemctl daemon-reload
systemctl enable restaurant-server
systemctl start restaurant-server
