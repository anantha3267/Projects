module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_value = "ami-0261755bbcb8c4a84"
    instance_type_value = "t2.micro"
}