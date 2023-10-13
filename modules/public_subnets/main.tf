resource "google_compute_subnetwork" "pc_public_subnet01" {
  name          = "subnet1" 
  network       = var.vpc_id
  ip_cidr_range = var.subnet01_cidr
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "pc_public_subnet02" {
  name          = "subnet2"
  network       = var.vpc_id
  ip_cidr_range = var.subnet02_cidr 
  private_ip_google_access = true
}

resource "google_compute_route" "pc_pub_route" {
  name             = "internet-gateway"
  network          = var.vpc_id
  dest_range       = "0.0.0.0/0"  
  next_hop_gateway = "default-internet-gateway"  
  description      = "Default route to the Internet."
}

output "my_pc_public_subnet_output01" {
  value = google_compute_subnetwork.pc_public_subnet01.self_link
}

output "my_pc_public_subnet_output02" {
  value = google_compute_subnetwork.pc_public_subnet02.self_link
}

output "my_pc_pub_route_output" {
  value = google_compute_route.pc_pub_route.self_link
}