variable "AWS_REGION" {
  default = "us-west-2"
}

variable "ENV" {
  description = "The environment setting for this project"
  type = string
  default = "dev"
}

variable "SERVICE" {
  description = "The name of this directory's microservice"
  type        = string
  default     = "proxy"
}




