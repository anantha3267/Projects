module "my_s3_bucket" {
  source = "./s3_module"
}

output "s3_output" {
  value = module.my_s3_bucket.bucket_name
}