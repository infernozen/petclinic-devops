terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

provider "google" {
  project = "infernozen"
  region = var.region
}

terraform {
 backend "gcs" {
   bucket  = "infernozen-bucket-tfstate"  # replace with your bucket name
   prefix  = "terraform/state"
 }
}

module "vpc" {
  source = "./modules/vpc"
}

module "public-subnet"{
  source         = "./modules/public_subnets"
  env_prefix     = var.env_prefix
  pub_route_cidr = var.pub_route_cidr
  subnet01_cidr  = var.subnet01_cidr
  subnet02_cidr  = var.subnet02_cidr
  vpc_id         = module.vpc.my_pc_vpc_output
}

module "private-subnet" {
  source         = "./modules/private_subnets"
  env_prefix     = var.env_prefix
  subnet03_cidr  = var.subnet03_cidr
  subnet04_cidr  = var.subnet04_cidr
  vpc_id         = module.vpc.my_pc_vpc_output
  nat_gw         = module.nat-gateway.nat_gateway_self_link 
}

module "nat-gateway"{
  source         = "./modules/cloud_nat"
  vpc_id         = module.vpc.my_pc_vpc_output
  priv_subnet01  = module.private-subnet.my_pc_private_subnet_output01
  priv_subnet02  = module.private-subnet.my_pc_private_subnet_output02
}

module "firewall"{
  source         = "./modules/firewall_rules"
  vpc_id         = module.vpc.my_pc_vpc_output
  ports_vm       = var.ports_vm
  ports_lb       = var.ports_lb
  ports_sql      = var.ports_sql  
}

module "mysql"{
  source          = "./modules/cloud_sql"
  region          = var.region
  username        = var.SQL_USERNAME
  password        = var.SQL_PASSWORD
  root            = var.root_password
  vpc_id          = module.vpc.my_pc_vpc_output
}

module "instance-group"{
  source           = "./modules/web_server"
  private_subnet1  = module.private-subnet.my_pc_private_subnet_output01
  private_subnet2  = module.private-subnet.my_pc_private_subnet_output02
  sql_endpoint     = module.mysql.db_instance_endpoint
  username         = var.SQL_USERNAME
  password         = var.SQL_PASSWORD
  root_password    = var.root_password
  image            = var.image
  instance_type    = var.instance_type1
  env_prefix       = var.env_prefix  
  depends_on       = [ module.mysql ]   
}
