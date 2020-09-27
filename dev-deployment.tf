terraform {
  # Note: Pinned Terraform version because older versions can't read the state written by newer versions
  required_version = "0.13.3"

  backend "gcs" {}
}

module "main" {
  source = "./module"

  name = "something"
}
