# creating vpc
resource "google_compute_network" "pc_vpc" {
  project = "infernozen"
  name = "pc-vpc"
  auto_create_subnetworks = false
  # delete_default_routes_on_create = true
}

output "my_pc_vpc_output" {
  value = google_compute_network.pc_vpc.self_link
}