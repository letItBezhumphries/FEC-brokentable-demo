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

variable "REVIEWS_SG_ID" {
}

variable "SERVICE" {
  description = "The name of the microservice for this instance."
  type        = string
  default     = "reviews"
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
