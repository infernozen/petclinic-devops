resource "google_compute_router" "nat-router" {
  name = "nat-router"
  network = var.vpc_id
}

resource "google_compute_router_nat" "cloud-nat" {
  name                   = "nat-config"
  router                 = google_compute_router.nat-router.name
  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" # Replace with the specific private subnets you want to NAT
  subnetwork {
    name                    = var.priv_subnet01
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  subnetwork {
    name                    = var.priv_subnet02
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ALL"
  }
}

# Note: You'll need to configure firewall rules to allow/deny traffic as needed.
output "nat_gateway_self_link" {
  value = google_compute_router.nat-router.self_link
}

