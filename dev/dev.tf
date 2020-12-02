
module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "restaurant-db" {
  source            = "../modules/data-stores/mysql/restaurants-db"
  ENV               = var.ENV
  VPC_ID            = module.main-vpc.vpc_id
  PRIVATE_SUBNETS   = module.main-vpc.private_subnets
  PUBLIC_SUBNETS    = module.main-vpc.public_subnets
  DB_NAME           = var.RESTAURANT_DB_NAME
  MYSQL_PASSWORD    = var.MYSQL_PASSWORD
  MYSQL_USERNAME    = var.MYSQL_USERNAME
  RDS_AZ            = "${var.AWS_REGION}a"
  RESTAURANT_SG_ID  = module.restaurant-service.restaurant_sgid
}

module "restaurant-service" {
  source          = "../modules/services/restaurants-server"
  ENV             = var.ENV
  VPC_ID          = module.main-vpc.vpc_id
  PUBLIC_SUBNETS  = module.main-vpc.public_subnets
  AMI_ID          = var.RESTAURANT_AMI_ID
  DB_NAME         = var.RESTAURANT_DB_NAME
  MYSQL_PASSWORD  = var.MYSQL_PASSWORD
  MYSQL_USERNAME  = var.MYSQL_USERNAME
  RDS_ENDPOINT    = module.restaurant-db.restaurant_rds_endpoint
  host            = split(":", module.restaurant-db.restaurant_rds_endpoint)[0]
  port            = split(":", module.restaurant-db.restaurant_rds_endpoint)[1]
}
