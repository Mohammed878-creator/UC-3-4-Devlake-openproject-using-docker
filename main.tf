terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.10.0"
}

module "ec2_instance" {

  source = "./modules/instance"
  count_details = var.count_numbers
  ami = var.ami
  instance_type = var.instance_type
  public_subnet_ids = module.vpc_networking.public_subnet_ids
  security_groups_id_ec2 = module.vpc_networking.security_group_ec2
}

module "datalake" {
  source = "./modules/datalake"
  ami = var.ami
  instance_type = var.instance_type
  public_subnet_ids = module.vpc_networking.public_subnet_ids
  security_groups_id_ec2 = module.vpc_networking.security_group_ec2 
}

module "vpc_networking" {
  source = "./modules/networking"
  region = var.region
  vpc_cidr = var.vpc_cidr
  availability_zone = var.availability_zone
  public_subnet = var.public_subnets
}

module "alb" {
  source = "./modules/alb"
  security_groups_id_alb = module.vpc_networking.security_group_alb
  subnet_ids = module.vpc_networking.public_subnet_id
  target_group_name = "app_tg_group"
  tg_grp_port = 80
  tg_grp_protocal = "HTTP"
  vpc_id = module.vpc_networking.vpc_id_details
  listener_port = 80
  listener_protocol = "HTTP"
  target_ids = module.ec2_instance.instance_id
  instance_id2 = module.datalake.instance_details_data_lake
  tg_data_lake_grp_port = 4000
}