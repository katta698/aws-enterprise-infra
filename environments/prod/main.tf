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
  source                = "../../modules/compute"
  environment           = var.environment
  vpc_id                = module.network.vpc_id
  public_subnet_ids     = module.network.public_subnet_ids
  private_subnet_ids    = module.network.private_subnet_ids
  alb_sg_id             = module.security.alb_sg_id
  ec2_sg_id             = module.security.ec2_sg_id
  instance_profile_name = module.iam.ec2_instance_profile_name
  instance_type         = var.instance_type
}

module "monitoring" {
  source      = "../../modules/monitoring"
  environment = var.environment
  asg_name    = module.compute.asg_name
}

module "backup" {
  source      = "../../modules/backup"
  environment = var.environment
}
