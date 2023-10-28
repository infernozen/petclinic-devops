#Instance template
resource "google_compute_instance_template" "pc_instance_template_1" {
  name = "pc-instance-template-1"
  tags = [var.env_prefix]
  machine_type = var.instance_type

  disk {
    source_image = var.image
  }

  network_interface {
    subnetwork = var.private_subnet1
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata_startup_script = templatefile("${path.module}/templates/instance_init_config.sh", {
    ENDPOINT       = var.sql_endpoint
    MYSQL_USERNAME = var.username
    MYSQL_PASSWORD = var.password
    ROOT_PASSWORD  = var.root_password
  })

  service_account {
    email  = "compute-admin@infernozen.iam.gserviceaccount.com"
    scopes = ["userinfo-email", "compute-ro", "storage-ro","sql-admin"]
  }
}

#Instance template
# resource "google_compute_instance_template" "pc_instance_template_2" {
#   name = "pc-instance-template-2"
#   tags = [var.env_prefix]
#   machine_type = var.instance_type

#   disk {
#     source_image = var.image
#   }

#   network_interface {
#     subnetwork = var.private_subnet2
#   }

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#   }

#   metadata_startup_script = templatefile("${path.module}/templates/instance_init_config.sh", {
#     ENDPOINT       = var.sql_endpoint
#     MYSQL_USERNAME = var.username
#     MYSQL_PASSWORD = var.password
#     ROOT_PASSWORD  = var.root_password
#   })

#   service_account {
#     email  = "compute-admin@infernozen.iam.gserviceaccount.com"
#     scopes = ["userinfo-email", "compute-ro", "storage-ro"]
#   }
# }

#custom health-check
resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  unhealthy_threshold = 10

  http_health_check {
    port         = "8080"
  }
}


resource "google_compute_autoscaler" "pc_autoscaler" {
  name   = "pc-autoscaler"
  zone   = "asia-south1-c"
  target = google_compute_instance_group_manager.pcserver_1.id

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.80
    }
  }
}

resource "google_compute_instance_group_manager" "pcserver_1" {
  name = "pc-server-1"

  base_instance_name = "pc-zone-a"
  zone               = "asia-south1-c"

  version {
    instance_template  = google_compute_instance_template.pc_instance_template_1.self_link_unique
  }
  # target_pools = [google_compute_target_pool.default.id]
  target_size  = 1

  named_port {
    name = "http"
    port = 8080
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 10
  }
}