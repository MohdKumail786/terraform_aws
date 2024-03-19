terraform {
  backend "s3" {
    bucket = "mkashraf-prod"
    key    = "terraform/uat_infra_terraform"
    region = "us-east-1"
  }
}
