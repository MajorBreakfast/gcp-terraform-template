# Help: Google provider docs: https://registry.terraform.io/providers/hashicorp/google/latest/docs

data "google_client_config" "current" {}

resource "google_storage_bucket" "main" {
  name                        = "${var.name}-${data.google_client_config.current.project}"
  location                    = "EU"
  uniform_bucket_level_access = true
}

resource "google_service_account" "reader" {
  account_id = "${var.name}-reader"
}

resource "google_storage_bucket_iam_member" "reader" {
  bucket = google_storage_bucket.main.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.reader.email}"
}

resource "google_storage_bucket_object" "file" {
  bucket  = google_storage_bucket.main.name
  name    = "file"
  content = "hello world!"
}
