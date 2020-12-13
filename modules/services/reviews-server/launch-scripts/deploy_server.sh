#!/bin/bash

set -x

#set npm config permissions
sudo -E chown -R ubuntu:ubuntu /home/ubuntu/.config

# Create .env file to store 'dotenv' variables needed to seed db
sudo -u ubuntu touch /home/ubuntu/FEC-Reviews-Module/.env
sudo -u ubuntu touch /home/ubuntu/FEC-Reviews-Module/.my.cnf

# Create the $HOME directory
echo "export HOME=/home/ubuntu" >> /home/ubuntu/.profile

# Add the variables passed in from cloudinit.tf to the .env file
cat > /home/ubuntu/FEC-Reviews-Module/.env << _EOF
RDS_USERNAME=${RDS_USERNAME}
RDS_PASSWORD=${RDS_PASSWORD}
RDS_HOST=${RDS_HOST}
RDS_PORT=${RDS_PORT}
DB_NAME=${DB_NAME}
_EOF

# Add the variables and values to mysql client config file
cat > /home/ubuntu/FEC-Reviews-Module/.my.cnf << _EOF
[client]
user=${RDS_USERNAME}
host=${RDS_HOST}
password=${RDS_PASSWORD}
_EOF

# Run the sql file against restaurant_details to add necessary tables
mysql --defaults-file=/home/ubuntu/FEC-Reviews-Module/.my.cnf -e "CREATE DATABASE IF NOT EXISTS Review_Module"

sleep 10

# run the seeding script to seed the database
cd /home/ubuntu/FEC-Reviews-Module && npm run seed

# run the webpack build command
cd /home/ubuntu/FEC-Reviews-Module && npm run build

# create systemd service file to start and enable reviews-server on ec2 launch
sudo -E cat > /etc/systemd/system/reviews-server.service << _EOF
[Unit]
Description=reviews_server.js
Documentation=https://example.com
After=network.target

[Service]
Environment=HOME=/home/ubuntu RDS_USERNAME=${RDS_USERNAME} RDS_PASSWORD=${RDS_PASSWORD} RDS_HOST=${RDS_HOST} RDS_PORT=${RDS_PORT} DB_NAME=${DB_NAME}
ExecStart=/usr/bin/node /home/ubuntu/FEC-Reviews-Module/server/server.js
Type=simple
WorkingDirectory=/home/ubuntu/FEC-Reviews-Module
#Restart=always
#RestartSec=10
Restart=on-failure
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=reviews-server
User=ubuntu

[Install]
WantedBy=multi-user.target
_EOF

# Enable and start reviews-server as a service on boot
systemctl daemon-reload
systemctl enable reviews-server
systemctl start reviews-server
