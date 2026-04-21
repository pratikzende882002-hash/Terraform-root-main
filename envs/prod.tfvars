environment = "prod"
project_name = "myapp"
aws_region = "ap-south-1"
vpc_cidr = "10.2.0.0/16"
bucket_suffix = "myapp-prod-bucket_87287"


tags = {
    owner = "Platform Team"
    Costcenter = "cc-prod-003"
    Terraform = "true"
}

subnets = {
    "public-subnet" = { cidr = "10.2.1.0/24", az = "ap-south-1a", is_public = true }
    "private-subnet" = { cidr = "10.2.2.0/24", az = "ap-south-1a", is_public = false }
}

ec2_instances = {
    "web-server-1" = {ami_id = "ami-05d2d839d4f73aafb", instance_type = "t2.micro", subnet_key = "public_subnet" }
    "web-server-2" = {ami_id = "ami-05d2d839d4f73aafb", instance_type = "t2.micro", subnet_key = "public_subnet" }
}
