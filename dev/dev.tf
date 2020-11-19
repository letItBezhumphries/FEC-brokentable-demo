
module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "restaurant-service" {
  source          = "../modules/services/restaurant-service"
  ENV             = var.ENV
  VPC_ID          = module.main-vpc.vpc_id
  PUBLIC_SUBNETS  = module.main-vpc.public_subnets
  #PRIVATE_SUBNETS = module.main-vpc.private_subnets
  AMI_ID          = var.RESTAURANT_AMI_ID
  RDS_PASSWORD    = var.RDS_PASSWORD
  RDS_ENDPOINT    = module.restaurant-db.restaurant_rds_endpoint
  host            = split(":", module.restaurant-db.restaurant_rds_endpoint)[0]
  port            = split(":", module.restaurant-db.restaurant_rds_endpoint)[1]
}

module "restaurant-db" {
  source            = "../modules/data-stores/mysql-restaurant"
  ENV               = var.ENV
  VPC_ID            = module.main-vpc.vpc_id
  PRIVATE_SUBNETS   = module.main-vpc.private_subnets
  PUBLIC_SUBNETS    = module.main-vpc.public_subnets
  RDS_PASSWORD      = var.RDS_PASSWORD
  RDS_AZ            = "${var.AWS_REGION}a"
  RESTAURANT_SG_ID  = module.restaurant-service.restaurant_sgid
}


