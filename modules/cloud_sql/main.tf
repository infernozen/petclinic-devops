resource "google_sql_database_instance" "my-pc-sql" {
  name                = "petclinic-sql"
  database_version    = "MYSQL_5_7"
  region              = var.region
  deletion_protection = false
  
  settings {
    tier              = "db-f1-micro"
    disk_size         = 10
    activation_policy = "ALWAYS"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    password_validation_policy {
      enable_password_policy = true
      min_length             = 4
    }
    ip_configuration {
      ipv4_enabled           = true
      authorized_networks {
        value = var.private_subnet1
      }
      authorized_networks {
        value = var.private_subnet2
      }
    }
  }
  root_password = var.password
}

resource "google_sql_database" "my-database" {
  name     = "mydb"
  instance = google_sql_database_instance.my-pc-sql.name
}

resource "google_sql_user" "my-db-user" {
  name     = var.username
  password = var.password
  instance = google_sql_database_instance.my-pc-sql.name
}

resource "google_sql_ssl_cert" "my-db-ssl-cert" {
  instance    = google_sql_database_instance.my-pc-sql.name
  common_name = "mysql-cert"
}

output "db_instance_endpoint" {
  value = google_sql_database_instance.my-pc-sql.ip_address
}
