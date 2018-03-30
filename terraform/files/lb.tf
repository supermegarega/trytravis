resource "google_compute_instance_group" "reddit-grp" {
  name        = "reddit-grp"
  description = "reddit instance group"
  zone        = "${var.zone}"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "reddit-port"
    port = "9292"
  }
}

resource "google_compute_http_health_check" "reddit-health-check" {
  name               = "reddit-health-check"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  port               = "9292"
}

resource "google_compute_backend_service" "reddit-backend" {
  name        = "reddit-backend"
  description = "Backend service for Reddit"
  port_name   = "reddit-port"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = "${google_compute_instance_group.reddit-grp.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.reddit-health-check.self_link}"]
}

resource "google_compute_url_map" "reddit-map" {
  name        = "reddit-map"
  description = "Url Map for reddit"

  default_service = "${google_compute_backend_service.reddit-backend.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.reddit-backend.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.reddit-backend.self_link}"
    }
  }
}

resource "google_compute_target_http_proxy" "reddit-http-proxy" {
  name        = "reddit-http-proxy"
  description = "Http proxy reddit"
  url_map     = "${google_compute_url_map.reddit-map.self_link}"
}

resource "google_compute_global_forwarding_rule" "reddit-forwarding-rule" {
  name       = "reddit-forwarding-rule"
  target     = "${google_compute_target_http_proxy.reddit-http-proxy.self_link}"
  port_range = "80"
}
