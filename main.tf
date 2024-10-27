provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source                    = "./ec2_instances"
  public_subnet_id          = module.subnet.public_subnet_id
  private_subnet_id         = module.private_subnet.private_subnet_id
  public_security_group_id  = module.security_groups.public_security_group_id
  private_security_group_id = module.security_groups.private_security_group_id
}

module "private_subnet" {
  source = "./private_subnet"
  vpc_id = module.vpc.vpc_id
}
