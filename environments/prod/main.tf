provider "aws" {
  region = var.aws_region
}

module "network" {
  source               = "../../modules/network"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security" {
  source      = "../../modules/security"
  environment = var.environment
  vpc_id      = module.network.vpc_id
}

module "iam" {
  source      = "../../modules/iam"
  environment = var.environment
}

module "compute" {
  source               = "../../modules/compute"
  environment          = var.environment
  vpc_id               = module.network.vpc_id
  public_subnets       = module.network.public_subnets
  private_subnets      = module.network.private_subnets
  alb_sg_id            = module.security.alb_sg_id
  ec2_sg_id            = module.security.ec2_sg_id
  instance_type        = var.instance_type
  iam_instance_profile = module.iam.ec2_profile_name
}

module "backup" {
  source      = "../../modules/backup"
  environment = var.environment

  # Connected Missing parameters to root variables/IAM outputs
  kms_key_arn     = module.security.kms_key_arn
  backup_role_arn = module.iam.backup_role_arn
  retention_days  = 30 # Stricter lifecycle retention window for Production
}
