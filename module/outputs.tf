output "bucket_name" {
  description = "A Cloud Storage bucket"
  value       = google_storage_bucket.main.name
}

output "reader_service_account_email" {
  description = "A service account with read permissions to the bucket"
  value       = google_service_account.reader.email
}
