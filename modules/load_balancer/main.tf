resource "google_compute_global_address" "pc-lb-ip-address" {
  name = "lb-ip-address"
  ip_version = "IPV4"
}

resource "google_compute_backend_service" "pc-backend-service" {
  name     = "pc-backend-service"
  protocol = "HTTP"
  timeout_sec = 10
  port_name   = "http"

  backend {
    group = var.pc_server1
  }
  health_checks = [var.health_check]
}

resource "google_compute_url_map" "pc-urlmap" {
  name        = "pc-urlmap"
  default_service = google_compute_backend_service.pc-backend-service.id
  host_rule {
    hosts        = ["infernozen.cloud"]
    path_matcher = "allpaths"
  }

  host_rule {
    hosts        = ["www.infernozen.cloud"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.pc-backend-service.id
  }
}

resource "google_compute_target_http_proxy" "pc-target-http-proxy" {
  name = "pc-target-http-proxy"
  url_map = google_compute_url_map.pc-urlmap.id
}

resource "google_compute_managed_ssl_certificate" "pc-cert" {
  name = "pc-cert"
  managed {
    domains = ["infernozen.cloud","www.infernozen.cloud"]
  }
}

resource "google_compute_target_https_proxy" "pc-target-https-proxy" {
  name = "pc-target-https-proxy"
  url_map = google_compute_url_map.pc-urlmap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.pc-cert.self_link]
}

resource "google_compute_global_forwarding_rule" "pc-forwarding-rule-1" {
  name = "pc-forwarding-rule-1"
  target = google_compute_target_http_proxy.pc-target-http-proxy.self_link
  ip_address = google_compute_global_address.pc-lb-ip-address.self_link
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "pc-forwarding-rule-2" {
  name       = "forwarding-rule-2"
  target     = google_compute_target_https_proxy.pc-target-https-proxy.self_link
  ip_address = google_compute_global_address.pc-lb-ip-address.self_link
  port_range = "443"
}

output "lb_ip_address"{
    value = google_compute_global_forwarding_rule.pc-forwarding-rule-2.ip_address
}

