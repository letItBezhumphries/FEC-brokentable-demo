#!/bin/bash

set -ex

ARTIFACT=`packer build -machine-readable images-packer.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "IMAGES_AMI_ID" { default = "'${AMI_ID}'" }' > images-amivar.tf


