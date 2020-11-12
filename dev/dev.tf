module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "dev"
  AWS_REGION = var.AWS_REGION
}

#module "proxy-instance" {
 #source         = "../modules/proxy-instance"
 # ENV            = "dev"
 # VPC_ID         = module.main-vpc.vpc_id
 # PUBLIC_SUBNETS = module.main-vpc.public_subnets
#}

module "restaurant-instance" {
  source         = "../modules/restaurant-instance"
  ENV            = "dev"
  VPC_ID         = module.main-vpc.vpc_id
  PUBLIC_SUBNETS = module.main-vpc.public_subnets
}

#module "reviews-instance" {
#  source         = "../modules/reviews-instance"
#  ENV            = "dev"
#  VPC_ID         = module.main-vpc.vpc_id
#  PUBLIC_SUBNETS = module.main-vpc.public_subnets
#}

#module "photogallery-instance" {
#  source         = "../modules/photogallery-instance"
#  ENV            = "dev"
#  VPC_ID         = module.main-vpc.vpc_id
#  PUBLIC_SUBNETS = module.main-vpc.public_subnets
#}

