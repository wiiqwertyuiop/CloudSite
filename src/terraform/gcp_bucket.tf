# Create new storage bucket in the US multi-region
# with standard storage
resource "google_storage_bucket" "static" {
 name          = "wiiq-static-site-final"
 location      = "US-EAST1"
 storage_class = "STANDARD"
 project       = "wiiq-proj"
 uniform_bucket_level_access = true
}

# Access control
resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.static.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Upload all files to bucket
resource "google_storage_bucket_object" "files" {
 for_each = fileset("${path.root}/../web", "**")
 name         = each.value
 source       = "../web/${each.value}"
 bucket       = google_storage_bucket.static.id
 cache_control = 360
}