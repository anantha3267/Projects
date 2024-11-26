provider "aws" {
  region = "us-east-1" # Choose the region
}

# Create an S3 bucket to act as the CloudFront origin
resource "aws_s3_bucket" "origin_bucket" {
  bucket        = "example-origin-bucket"
  acl           = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Example S3 Bucket"
    Environment = "Production"
  }
}

# Add a bucket policy to allow CloudFront access
resource "aws_s3_bucket_policy" "origin_bucket_policy" {
  bucket = aws_s3_bucket.origin_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.origin_bucket.arn}/*"
      }
    ]
  })
}

# Create an Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "oac" {
  name       = "example-oac"
  description = "Access control for CloudFront to access S3 origin"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

# Create a CloudFront distribution
resource "aws_cloudfront_distribution" "example_distribution" {
  origin {
    domain_name = aws_s3_bucket.origin_bucket.bucket_regional_domain_name
    origin_id   = "exampleS3Origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled      = true
  comment              = "Example CloudFront distribution"
  default_root_object  = "index.html"

  default_cache_behavior {
    target_origin_id       = "exampleS3Origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Environment = "Production"
  }
}
