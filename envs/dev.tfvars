environment = "dev"
project_name = "myapp"
aws_region = "ap-south-1"
vpc_cidr = "10.0.0.0/16"
bucket_suffix = "myapp-dev-bucket_87287"


tags = {
    owner = "Dev Team"
    Costcenter = "cc-dev-001"
    Terraform = "true"
}


subnets = {
    "public-subnet-1" = { cidr = "10.0.1.0/24", az = "ap-south-1a", is_public = true }
    "private-subnet-1" = { cidr = "10.0.2.0/24", az = "ap-south-1b", is_public = false }
}


ec2_instances = {
    "web-server-1" = {ami_id = "ami-05d2d839d4f73aafb", instance_type = "t2.micro", subnet_key = "public-subnet-1" }
    "web-server-2" = {ami_id = "ami-05d2d839d4f73aafb", instance_type = "t2.micro", subnet_key = "public-subnet-1" }
}
