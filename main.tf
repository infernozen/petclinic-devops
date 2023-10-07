terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

terraform {
 backend "gcs" {
   bucket  = "infernozen-bucket-tfstate"  # replace with your bucket name
   prefix  = "terraform/state"
   project = "infernozen"
 }
}

provider "google" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "pub-subnet"{
  source         = "./modules/public_subnets"
  env_prefix     = var.env_prefix
  subnet01_cidr = var.subnet01_cidr
  subnet02_cidr = var.subnet02_cidr
  vpc_id         = module.vpc.my_pc_vpc_output
}
