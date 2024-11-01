# versions.tf

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0" # Certifique-se de que a versão é 4.0 ou superior
    }
  }
}


provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  AZ                  = var.AZ
  vpc_name            = "vpc_cp3"
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  alb_name                         = "external-ALB"
  internal                         = false
  security_group_ids               = [module.security_groups.alb_sg_id]
  subnet_ids                       = module.vpc.public_subnet_ids
  target_group_name                = "external-web-group"
  target_group_port                = 80
  target_group_protocol            = "HTTP"
  vpc_id                           = module.vpc.vpc_id
  listener_port                    = 80
  listener_protocol                = "HTTP"
  health_check_path                = "/"
  health_check_protocol            = "HTTP"
  health_check_interval            = 30
  health_check_timeout             = 5
  health_check_healthy_threshold   = 5
  health_check_unhealthy_threshold = 2
  tags = {
    Name = "external-ALB"
  }
}

module "ec2" {
  source = "./modules/ec2"

  ami               = var.ami
  instance_type     = var.instance_type
  public_subnet_ids = module.vpc.public_subnet_ids
  webtier_sg_id     = module.security_groups.webtier_sg_id
  user_data         = var.user_data
  target_group_arn  = module.alb.target_group_arn
  desired_capacity  = 2
  max_size          = 5
  min_size          = 2
  tags = {
    Environment = "Production"
  }
}
