terraform {
  required_version = "~> 1.11.0"

  backend "s3" {
    bucket       = "ulags-state-files"
    key          = "backend/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
