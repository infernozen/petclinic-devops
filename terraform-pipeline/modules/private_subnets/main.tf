# creating two private subnets
resource "google_compute_subnetwork" "pc_private_subnet01" {
  name          = "private-subnet1" 
  network       = var.vpc_id
  ip_cidr_range = var.subnet01_cidr
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "pc_private_subnet02" {
  name          = "private-subnet2"
  network       = var.vpc_id
  ip_cidr_range = var.subnet02_cidr 
  private_ip_google_access = true
}

output "my_pc_private_subnet_output01" {
  value = google_compute_subnetwork.pc_private_subnet01.self_link
}

output "my_pc_private_subnet_output02" {
  value = google_compute_subnetwork.pc_private_subnet02.self_link
}
