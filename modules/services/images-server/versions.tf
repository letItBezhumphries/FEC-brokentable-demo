terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
