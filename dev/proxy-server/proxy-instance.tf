
module "main-vpc" {
  source     = "../../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "proxy-service" {
  source          = "../../modules/services/proxy-server"
  ENV             = var.ENV
  VPC_ID          = module.main-vpc.vpc_id
  PUBLIC_SUBNETS  = module.main-vpc.public_subnets
  AMI_ID          = var.PROXY_AMI_ID
}
