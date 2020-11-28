variable "ENV" {
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

