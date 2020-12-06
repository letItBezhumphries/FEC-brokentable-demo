#!/bin/bash

set -x

# add the application as a group, called restaurant-server
groupadd restaurant-server

# add application as system user
useradd -d /FEC-Restaurant-Info-Module -s /bin/false -g restaurant-server restaurant-server

DOTENV_PASSWORD="RDS_PASSWORD="${RDS_PASSWORD}
DOTENV_HOSTNAME="RDS_HOSTNAME="${RDS_HOST}
DOTENV_USERNAME="RDS_USERNAME="${RDS_USERNAME}
DOTENV_PORT="RDS_PORT="${RDS_PORT}
DOTENV_DB_NAME="DB_NAME="${DB_NAME}
BASHENV_RDS_PASSWORD="export RDS_PASSWORD="${RDS_PASSWORD}
BASHENV_RDS_HOST="export RDS_HOST="${RDS_HOST}

# Create .env file for DOTENV variables and append password and hostname into .env
sudo -u ubuntu touch /home/ubuntu/FEC-Restaurant-Info-Module/.env

echo $BASHENV_RDS_PASSWORD >> /home/ubuntu/.bashrc
echo $BASHENV_RDS_HOST >> /home/ubuntu/.bashrc

# Add the above variables to the .env file
echo $DOTENV_PASSWORD >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_HOSTNAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_USERNAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_PORT >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_DB_NAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env

# Create the mysql database restaurant_details
sudo mysql -u ${RDS_USERNAME} -h ${RDS_HOST} -p${RDS_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS restaurant_details" 

# Run the sql file against restaurant_details to add necessary tables
sudo mysql -u ${RDS_USERNAME} -h ${RDS_HOST} -p${RDS_PASSWORD} -D ${DB_NAME} < /home/ubuntu/FEC-Restaurant-Info-Module/server/restaurants.sql

# sleep and give time for previous command
sleep 5

# run the webpack build command
cd /home/ubuntu/FEC-Restaurant-Info-Module && npm run build

# change owner of appication files to restaurant-server
chown -R restaurant-server:restaurant-server /home/ubuntu/FEC-Restaurant-Info-Module

echo '[Service]
ExecStart=/usr/bin/nodejs /home/ubuntu/FEC-Restaurant-Info-Module/server/server.js
WorkingDirectory=/home/ubuntu/FEC-Restaurant-Info-Module
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=restaurant-server
User=restaurant-server
Group=restaurant-server
#User=ubuntu
#Group=ubuntu
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/restaurant-server.service

# Enable and start restaurant-server as a service on boot
systemctl enable restaurant-server
systemctl start restaurant-server
