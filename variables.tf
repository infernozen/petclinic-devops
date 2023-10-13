variable "region" {}

variable "env_prefix"{}

variable "instance_type1" {}
variable "instance_type2" {}

variable "pub_route_cidr"{}

variable "subnet01_cidr" {}
variable "subnet02_cidr" {}

variable "subnet03_cidr" {}
variable "subnet04_cidr" {}
variable "subnet05_cidr" {}

variable "ports_vm" {
  type = list(number)
}

variable "ports_lb" {
  type = list(number)
}

variable "ports_sql" {
  type = list(number)
}

variable "image" {}



