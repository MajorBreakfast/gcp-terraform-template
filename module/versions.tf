terraform {
  required_version = ">=0.13.3"

  # Note: Pinned provider versions for deterministic CI pipelines
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.40.0"
    }
  }
}
