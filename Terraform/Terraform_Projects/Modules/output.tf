# output.tf in the root module
output "public_ip_address" {
  value = module.ec2_instance.public_ip_address
}
