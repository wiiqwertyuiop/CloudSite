# Create new storage bucket in the US multi-region
# with standard storage
resource "google_storage_bucket" "static" {
 name          = var.bucket_name
 location      = "US-EAST1"
 storage_class = "STANDARD"
 uniform_bucket_level_access = false
 website {
  main_page_suffix = "main.html"
  not_found_page   = "error.html"
 }
}

# Access control
resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.static.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.static.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Upload all files to bucket
resource "google_storage_bucket_object" "files" {
 for_each     = fileset("${path.root}/../web", "**")
 name         = each.value
 source       = "../web/${each.value}"
 bucket       = google_storage_bucket.static.id
 cache_control = 360
}