variable "AWS_REGION" {
  default = "us-west-2"
}

#variable "PATH_TO_PUBLIC_KEY" {
#  default = "devkey"
#}

#variable "PATH_TO_PRIVATE_KEY" {
#  default = "devkey.pub"
#}

variable "ENV" {
  description = "The environment setting for this project"
  type = string
  default = "dev"
}

#variable "DB_INSTANCE_CLASS" {
#  default = "db.t2.micro"
#}

#variable "INSTANCE_TYPE" {
#  default = "t2.micro"
#}


variable "RDS_PASSWORD" {}
