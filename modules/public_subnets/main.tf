resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet1" 
  network       = var.vpc_id
  ip_cidr_range = var.subnet01_cidr
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet2"
  network       = var.vpc_id
  ip_cidr_range = var.subnet02_cidr 
  private_ip_google_access = true
}