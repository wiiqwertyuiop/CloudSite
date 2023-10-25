resource "google_compute_managed_ssl_certificate" "default" {
  name = "wiiq-cert"
  managed {
    domains = ["wiiq.xyz", "www.wiiq.xyz"]
  }
}

resource "google_compute_target_https_proxy" "default" {
  name             = "wiiq-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_url_map" "default" {
  name        = "basic-url-map"
  default_service = google_compute_backend_bucket.default.id
}

resource "google_compute_backend_bucket" "default" {
  name        = "site-backend-bucket"
  description = "Contains a static site"
  bucket_name = var.bucket_name
  enable_cdn  = true
}

resource "google_compute_global_address" "ip_address" {
  name = "my-address"
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "wiiq-forwarding-rule"
  target     = google_compute_target_https_proxy.default.id
  port_range = 443
  ip_address = google_compute_global_address.ip_address.id
}