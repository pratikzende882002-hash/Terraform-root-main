variable "aws_region" {
    description = "aws region"
    type = string
    default = "ap-south-1"
}


variable "environment" {
    description = "environment name"
    type = string
    validation{
        condition = contains(["dev", "staging", "prod"], var.environment)
        error_message = "Environment must be one of 'dev', 'staging', or 'prod'."
    }
  
}


variable "project_name" {
    description = "project name"
    type = string
    default = "my-terraform-project"
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}


variable "subnets" {
    description = "Map of subnet configurations"
    type = map(object({
        cidr       = string
        az         = string
        is_public  = bool
    }))
}

variable "ec2_instances" {
    description = "Map of EC2 instance configurations"
    type = map(object({
        ami_id          = string
        instance_type = string
        subnet_key    = string
    }))
  
}

variable "tags" {
    description = "Additional tags to apply to all resources"
    type = map(string)
    default = {}
  
}


variable "bucket_suffix" {
  description = "Unique suffix for the S3 bucket name"
  type        = string
}

