
module "main-vpc" {
  source     = "../../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "reviews-db" {
  source            = "../../modules/data-stores/mysql/reviews-db"
  ENV               = var.ENV
  VPC_ID            = module.main-vpc.vpc_id
  PRIVATE_SUBNETS   = module.main-vpc.private_subnets
  PUBLIC_SUBNETS    = module.main-vpc.public_subnets
  DB_NAME           = var.DB_NAME
  MYSQL_PASSWORD    = var.MYSQL_REVIEWS_PASSWORD
  MYSQL_USERNAME    = var.MYSQL_REVIEWS_USERNAME
  RDS_AZ            = "${var.AWS_REGION}a"
  REVIEWS_SG_ID     = module.reviews-service.reviews_sgid
  SERVICE           = var.SERVICE
}

module "reviews-service" {
  source          = "../../modules/services/reviews-server"
  ENV             = var.ENV
  VPC_ID          = module.main-vpc.vpc_id
  PUBLIC_SUBNETS  = module.main-vpc.public_subnets
  AMI_ID          = var.REVIEWS_AMI_ID
  DB_NAME         = var.DB_NAME
  MYSQL_PASSWORD  = var.MYSQL_REVIEWS_PASSWORD
  MYSQL_USERNAME  = var.MYSQL_REVIEWS_USERNAME
  RDS_ENDPOINT    = module.reviews-db.reviews_rds_endpoint
  host            = split(":", module.reviews-db.reviews_rds_endpoint)[0]
  port            = split(":", module.reviews-db.reviews_rds_endpoint)[1]
  SERVICE         = var.SERVICE
}
