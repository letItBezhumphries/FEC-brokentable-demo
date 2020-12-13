variable "ENV" {
  description = "The current environment for this project"
}

variable "PUBLIC_SUBNETS" {
  type = list
}

variable "PRIVATE_SUBNETS" {
  type = list
}

variable "RDS_AZ" {
}

variable "RESTAURANT_SG_ID" {
  description = "The securitygroup id for the restaurants-server"
}

variable "SERVICE" {
}

variable "VPC_ID" {
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "devkey.pub"
}

variable "MYSQL_PASSWORD" {
}

variable "MYSQL_USERNAME" {
}

variable "DB_NAME" {
}
