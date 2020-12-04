#!/bin/bash

set -x

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

echo $DOTENV_PASSWORD >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_HOSTNAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_USERNAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_PORT >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_DB_NAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env

# Run the shell script inside FEC-Restaurant-Info-Module that will create the mysql database
sudo mysql -u ${RDS_USERNAME} -h ${RDS_HOST} -p${RDS_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS restaurant_details" 

# Run the seed script to seed restaurant_details database with data.
sudo mysql -u ${RDS_USERNAME} -h ${RDS_HOST} -p${RDS_PASSWORD} -D ${DB_NAME} < /home/ubuntu/FEC-Restaurant-Info-Module/server/restaurants.sql

# sleep and give time for previous command
sleep 5

# start the server
cd /home/ubuntu/FEC-Restaurant-Info-Module && npm start
