terraform {
  backend "s3" {
    bucket = "buckerfortfstate"
    key    = "anantha/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "tf_lock"
  }
}
