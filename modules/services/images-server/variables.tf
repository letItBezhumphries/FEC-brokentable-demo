variable "ENV" {}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}

#variable "PRIVATE_SUBNETS" {
#  type = list
#}

variable "VPC_ID" {}

variable "PATH_TO_PUBLIC_KEY" {
  default = "devkey.pub"
}

variable "AMI_ID" {}

variable "MONGODB_PASSWORD" {}

variable "MONGODB_USERNAME" {}

variable "PORT" {}

variable "ATLAS_HOST" {}

variable "DB_NAME" {}

variable "SERVICE" {}

variable "AWS_VPC_CIDR" {}

variable "project_id" {}
