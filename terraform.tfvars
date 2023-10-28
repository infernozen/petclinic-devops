region = "asia-south1"

env_prefix = "pet-clinic"

instance_type1  = "e2-medium"
instance_type2 = "e2-medium"

//allow all
pub_route_cidr = "0.0.0.0/0"

//public
subnet01_cidr = "10.20.1.0/24"
subnet02_cidr = "10.20.2.0/24"

//private
subnet03_cidr = "10.20.3.0/24"
subnet04_cidr = "10.20.4.0/24"

image = "gcp-mi-1696510141" //ubuntu 22.04

ports_vm = [22, 80, 8080]
ports_lb = [22, 80, 443, 8080]
ports_sql = [3306]

#DB
SQL_USERNAME = "petclinic"
SQL_PASSWORD = "petclinic"
root_password = "root"





