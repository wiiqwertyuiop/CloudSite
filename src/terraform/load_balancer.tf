resource "google_compute_managed_ssl_certificate" "default" {
  name = "wiiq-cert"
  project = "wiiq-proj"
  managed {
    domains = ["wiiq.xyz"]
  }
}

resource "google_compute_target_https_proxy" "default" {
  name             = "wiiq-proxy"
  project = "wiiq-proj"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_url_map" "default" {
  name        = "basic-url-map"
  project = "wiiq-proj"
  default_service = google_compute_backend_bucket.default.id
}

resource "google_compute_backend_bucket" "default" {
  name        = "site-backend-bucket"
  project = "wiiq-proj"
  description = "Contains a static site"
  bucket_name = "wiiq-static-site-final"
  enable_cdn  = true
}

resource "google_compute_global_address" "ip_address" {
  name = "my-address"
  project = "wiiq-proj"
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "forwarding-rule"
  project    = "wiiq-proj"
  target     = google_compute_target_https_proxy.default.id
  port_range = 443
  ip_address = google_compute_global_address.ip_address.id
}