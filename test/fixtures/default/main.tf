terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
  }
}

data "google_client_config" "current" {}

resource "random_string" "name_suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  name = "test-${random_string.name_suffix.result}"
}

module "main" {
  source = "./../../../module"

  name = local.name
}

output "project" { value = data.google_client_config.current.project }
output "name" { value = local.name }
output "bucket_name" { value = module.main.bucket_name }
output "reader_service_account_email" { value = module.main.reader_service_account_email }
