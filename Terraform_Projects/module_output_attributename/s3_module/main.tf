resource "aws_s3_bucket" "name" {
    bucket = "my-unique-bucket-namesdfghjkl"
    acl    = "private"
}

output "bucket_name" {
  value = aws_s3_bucket.name.bucket
}