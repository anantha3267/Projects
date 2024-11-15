terraform {
  backend "s3" {
    bucket = "buckerfortfstate"
    key    = "anantha/terraform.tfstate"
    region = "us-east-1"
  }
}
