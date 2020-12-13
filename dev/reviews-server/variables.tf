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
  default     = "Review_Module"
}

variable "MYSQL_REVIEWS_PASSWORD" {}

variable "MYSQL_REVIEWS_USERNAME" {}

variable "SERVICE" {
  description = "The name of microservice for this cluster"
  type        = string
  default     = "reviews"
}
