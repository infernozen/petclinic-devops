variable "region" {}

variable "env_prefix"{}

variable "instance_type1" {}
variable "instance_type2" {}

variable "pub_route_cidr"{}

variable "subnet01_cidr" {}
variable "subnet02_cidr" {}

variable "ports_vm" {
  type = list(number)
}

variable "ports_sql" {
  type = list(number)
}

variable "image" {}

variable "SQL_USERNAME" {}
variable "SQL_PASSWORD" {}
variable "root_password" {}



