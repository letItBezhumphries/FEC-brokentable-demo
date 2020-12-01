#!/bin/bash

set -x

DOTENV_PASSWORD="RDS_PASSWORD="${RDS_PASSWORD}
DOTENV_HOSTNAME="RDS_HOSTNAME="${RDS_HOST}
DOTENV_USERNAME="RDS_USERNAME="${RDS_USERNAME}
DOTENV_PORT="RDS_PORT="${RDS_PORT}
BASHENV_RDS_PASSWORD="export RDS_PASSWORD="${RDS_PASSWORD}
BASHENV_RDS_HOST="export RDS_HOSTNAME="${RDS_HOST}

# Create .env file for DOTENV variables and append password and hostname into .env
sudo -u ubuntu touch /home/ubuntu/FEC-Restaurant-Info-Module/.env

echo $BASHENV_RDS_PASSWORD >> /home/ubuntu/.bashrc
echo $BASHENV_RDS_HOST >> /home/ubuntu/.bashrc

echo $DOTENV_PASSWORD >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_HOSTNAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_USERNAME >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
echo $DOTENV_PORT >> /home/ubuntu/FEC-Restaurant-Info-Module/.env
