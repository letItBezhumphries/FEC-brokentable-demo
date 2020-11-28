#!/bin/bash

set -x

sudo -u ubuntu touch /home/ubuntu/.env 

echo "ADDING_STUFF=itworked" >> /home/ubuntu/.env
echo "RDS_PASSWORD=${RDS_PASSWORD}" >> /home/ubuntu/.env

echo "export RDS_PASSWORD=${RDS_PASSWORD}" >> /home/ubuntu/.bash_profile && source /home/ubuntu/.bash_profile
echo "export RDS_USERNAME=${RDS_USERNAME}" >> /home/ubuntu/.bash_profile && source /home/ubuntu/.bash_profile
echo "export RDS_HOST=${RDS_HOST}" >> /home/ubuntu/.bash_profile && source /home/ubuntu/.bash_profile
