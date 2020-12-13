#!/bin/bash

set -x

# add the application as a group, called reviews-server
groupadd reviews-server

# add application as user
useradd -d /home/ubuntu/FEC-Reviews-Module -s /bin/false -g reviews-server reviews-server

tail -1 /etc/passwd

DOTENV_PASSWORD="RDS_PASSWORD="${RDS_PASSWORD}
DOTENV_HOSTNAME="RDS_HOSTNAME="${RDS_HOST}
DOTENV_USERNAME="RDS_USERNAME="${RDS_USERNAME}
DOTENV_PORT="RDS_PORT="${RDS_PORT}
DOTENV_DB_NAME="DB_NAME="${DB_NAME}
BASHENV_RDS_PASSWORD="export RDS_PASSWORD="${RDS_PASSWORD}
BASHENV_RDS_HOST="export RDS_HOST="${RDS_HOST}

# Create .env file for DOTENV variables needed to seed db
sudo -u ubuntu touch /home/ubuntu/FEC-Reviews-Module/.env

echo $BASHENV_RDS_PASSWORD >> /home/ubuntu/.bashrc
echo $BASHENV_RDS_HOST >> /home/ubuntu/.bashrc

# Add the above variables to the .env file
echo $DOTENV_PASSWORD >> /home/ubuntu/FEC-Reviews-Module/.env
echo $DOTENV_HOSTNAME >> /home/ubuntu/FEC-Reviews-Module/.env
echo $DOTENV_USERNAME >> /home/ubuntu/FEC-Reviews-Module/.env
echo $DOTENV_PORT >> /home/ubuntu/FEC-Reviews-Module/.env
echo $DOTENV_DB_NAME >> /home/ubuntu/FEC-Reviews-Module/.env

# Create the mysql database Review_Module
sudo mysql -u root -h ${RDS_HOST} -p${RDS_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS Review_Module"

# Run the seed script to seed Review_Module database with records.
cd /home/ubuntu/FEC-Reviews-Module && npm run seed

sleep 10

# Run the webpack build script
cd /home/ubuntu/FEC-Reviews-Module && npm run build

# change file permissions for application
sudo chown -R reviews-server:reviews-server /home/ubuntu/FEC-Reviews-Module

echo '[Service]
ExecStart=/usr/bin/nodejs /home/ubuntu/FEC-Reviews-Module/server/server.js
WorkingDirectory=/home/ubuntu/FEC-Reviews-Module
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=reviews-server
User=reviews-server
Group=reviews-server
#User=ubuntu
#Group=ubuntu
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/reviews-server.service

systemctl enable reviews-server
systemctl start reviews-server

