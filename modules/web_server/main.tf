resource "google_compute_instance" "pc_server1" {
  name         = "pc-app1"
  machine_type = var.instance_type
  zone         = "asia-south1-c"

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.private_subnet1
  }

  metadata_startup_script = templatefile("${path.module}/templates/instance_init_config.sh", {
    ENDPOINT       = var.sql_endpoint
    MYSQL_USERNAME = var.username
    MYSQL_PASSWORD = var.password
    ROOT_PASSWORD  = var.root_password
  })

  tags = [var.env_prefix]

  service_account {
    email  = "compute-admin@infernozen.iam.gserviceaccount.com"
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance" "pc_server2" {
  name         = "pc-app2"
  machine_type = var.instance_type
  zone         = "asia-south1-b"

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.private_subnet2
  }

  metadata_startup_script = templatefile("${path.module}/templates/instance_init_config.sh", {
    ENDPOINT       = var.sql_endpoint
    MYSQL_USERNAME = var.username
    MYSQL_PASSWORD = var.password
    ROOT_PASSWORD  = var.root_password
  })

  tags = [var.env_prefix]

  service_account {
    email  = "compute-admin@infernozen.iam.gserviceaccount.com"
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

output "private_instance01" {
  value = google_compute_instance.pc_server1.self_link
}

output "private_instance02" {
  value = google_compute_instance.pc_server2.self_link
}