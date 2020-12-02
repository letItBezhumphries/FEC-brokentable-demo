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
  default     = "restaurant_details"
}

variable "MYSQL_PASSWORD" {}

variable "MYSQL_USERNAME" {}
