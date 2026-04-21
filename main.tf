provider "aws" {
    region = ap-south-1
  
}


locals {
    name_prefix = "${var.project_name}-${var.environment}"


    common_tags = merge ({
        Project     = var.project_name
        Environment = var.environment
        Managesby = "Terraform"
    },
    var.tags
    )
}


#=====================================================================================================================================]

module "vpc" {
    source = "git::https://github.com/pratikzende882002-hash/Terraform-module-vpc.git"
    cidr_block = var.vpc_cidr
    name = "${local.name_prefix}-vpc"
    tags = local.common_tags
}



#=====================================================================================================================================]

module "subnet" {
    source = "git::https://github.com/pratikzende882002-hash/Terraform-module-subnet.git"

    for_each = var.subnet
    subnet_name = "${local.name_prefix}-${each.key}"
    vpc_id = module.vpc.vpc_id
    cidr_block = each.value.cidr
    availability_zone = each.value.az
    map_public_ip_on_launch = each.is_public
    tags = merge(local.common_tags, {SubnetType = each.value.is_public ? "public" : "private"})
}



#=====================================================================================================================================]

module "ec2_instance" {
    source = "git::https://github.com/pratikzende882002-hash/Terraform-module-ec2.git"
    
    for_each = var.ec2_instances 
    instance_name = "${local.name_prefix}-${each.key}"
    ami_id = each.value.ami
    instance_type = each.value.instance_type
    subnet_id = module.subnet[each.value.subnet_key].subnet_id
    vpc_id = module.vpc.vpc_id
    vpc_cidr = var.vpc_cidr
    environment = var.environment
    tags = merge(local.common_tags, {Role = "web-server"})
  
}

#=====================================================================================================================================]

module "s3_bucket" {
    source = "git::https://github.com/pratikzende882002-hash/Terraform-module-s3.git"
    bucket_name = "${local.name_prefix}-bucket"
    environment = var.environment
    tags = merge(local.common_tags, {Role = "storage"})

  
}
