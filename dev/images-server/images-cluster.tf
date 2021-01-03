
module "main-vpc" {
  source              = "../../modules/vpc"
  ENV                 = var.ENV
  AWS_REGION          = var.AWS_REGION
}

module "images-service" {
  source            = "../../modules/services/images-server"
  ENV               = var.ENV
  VPC_ID            = module.main-vpc.vpc_id
  PUBLIC_SUBNETS    = module.main-vpc.public_subnets
  AMI_ID            = var.IMAGES_AMI_ID
  SERVICE           = var.SERVICE
  DB_NAME           = var.DB_NAME
  MONGODB_PASSWORD  = var.MONGODB_PASSWORD
  MONGODB_USERNAME  = var.MONGODB_USERNAME
  ATLAS_HOST        = var.atlas_connection_string
  project_id        = var.project_id
  PORT              = 27017
  AWS_VPC_CIDR      = module.main-vpc.vpc_cidr_block
}
