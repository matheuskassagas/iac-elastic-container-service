terraform {
    backend "s3" {
    bucket = "mgk-terraform-state"
    key = "prod/terraformstate"
    region = "us-east-1"
  }
}