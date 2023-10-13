resource "google_compute_subnetwork" "pc_private_subnet01" {
  name          = "private-subent1" 
  network       = var.vpc_id
  ip_cidr_range = var.subnet03_cidr
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "pc_private_subnet02" {
  name          = "private-subnet2"
  network       = var.vpc_id
  ip_cidr_range = var.subnet04_cidr 
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "pc_private_subnet03" {
  name          = "private-subnet3"
  network       = var.vpc_id
  ip_cidr_range = var.subnet05_cidr 
  private_ip_google_access = true
}

# resource "google_compute_route" "pc_priv_route" {
#   name                  = "private-subnet-route"
#   network               = var.vpc_id
#   dest_range            = "0.0.0.0/0"  # Default route for all traffic
#   priority              = 1000  # Adjust priority as needed
#   tags                  = ["private-subnet-route"]
# }

# output "my_pc_priv_route_output" {
#   value = google_compute_route.pc_priv_route.self_link
# }

output "my_pc_private_subnet_output01" {
  value = google_compute_subnetwork.pc_private_subnet01.self_link
}

output "my_pc_private_subnet_output02" {
  value = google_compute_subnetwork.pc_private_subnet02.self_link
}

output "my_pc_private_subnet_output03" {
  value = google_compute_subnetwork.pc_private_subnet03.self_link
}