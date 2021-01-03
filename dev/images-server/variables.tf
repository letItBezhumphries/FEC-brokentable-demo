variable "AWS_REGION" {
  default = "us-west-2"
}

variable "ENV" {
  description = "The environment setting for this project"
  type = string
  default = "dev"
}

variable "DB_NAME" {
  description = "The name of the mysql database"
  type        = string
  default     = "photogallery"
}

variable "SERVICE" {
  description = "The name of this directory's microservice"
  type        = string
  default     = "images"
}

variable "INSTANCE_TYPE" {
  description = "The AWS ec2 instance type"
  type        = string
  default     = "t2.small"
}


variable "MONGODB_PASSWORD" {}

variable "MONGODB_USERNAME" {}

variable "MONGODB_ATLAS_PUBLIC_KEY" {}

variable "MONGODB_ATLAS_PRIVATE_KEY" {}

variable "MONGODB_ATLAS_ORG_ID" {}

variable "PROJECT_NAME" {
  description = "The name for the atlas project"
  default     = "brokentable"
}

variable "public_key" {}

variable "private_key" {}

variable "dbuser" {}

variable "dbuser_password" {}

variable "database_name" {}

variable "atlasorgid" {}

variable "atlas_region" {}

variable "mongodbversion" {}

variable "project_name" {}

variable "atlas_vpc_cidr" {}

variable "atlas_provider" {}

variable "aws_account_id" {}

variable "atlas_connection_string" {}

variable "project_id" {}
