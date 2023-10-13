//=======Firewall Rules for VMs=========
resource "google_compute_firewall" "pc_pub_fw" {
  name        = "pc-pub-fw"
  network     = var.vpc_id
  description = "Allow inbound traffic"

  dynamic "allow" {
    for_each = var.ports_vm
    iterator = myport
    content {
      protocol = "tcp"
      ports    = [myport.value]
    }
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["pc-pub-tag"]
}

//=======Firewall Rules for Load Balancer=========
resource "google_compute_firewall" "pc_lb_fw" {
  name        = "pc-lb-fw"
  network     = var.vpc_id
  description = "Allow inbound traffic"

  dynamic "allow" {
    for_each = var.ports_lb
    iterator = myport
    content {
      protocol = "tcp"
      ports    = [myport.value]
    }
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["pc-lb-tag"]
}

//=======Firewall Rules for SQL=========
resource "google_compute_firewall" "sql_fw" {
  name        = "sql-fw"
  network     = var.vpc_id
  description = "Allow inbound traffic"

  dynamic "allow" {
    for_each = var.ports_sql
    iterator = myport
    content {
      protocol = "tcp"
      ports    = [myport.value]
    }
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["sql-tag"]
}

//================ outputs =======================
output "my_pc_ec2_fw_output" {
  value = google_compute_firewall.pc_pub_fw.self_link
}

output "my_pc_alb_fw_output" {
  value = google_compute_firewall.pc_lb_fw.self_link
}

output "my_pc_rds_fw_output" {
  value = google_compute_firewall.sql_fw.self_link
}
