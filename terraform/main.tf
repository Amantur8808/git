#----------------------------------------------------------
# My Project
#
# 
#
# Made by Amantur Bolotbaev
#----------------------------------------------------------



provider "aws" {
  region = "us-east-1"
}
    
module "project" {
  source = "../modules/homework"
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  user_data = file("C:/project/terraform/user_data.sh")
}
   

terraform {
  backend "s3" {
    bucket = "dev-s3-bucket-for-terraform-project" 
    key    = "dev/network/terraform.tfstate"            
    region = "us-east-1"                                 
  }
}

data "aws_availability_zones" "available" {}

data "aws_ami" "latest_ubuntu" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

output "lates_ubuntu_ami_id" {
    value = data.aws_ami.latest_ubuntu.id
}

output "lates_ubuntu_ami_name" {
    value = data.aws_ami.latest_ubuntu.name
}

output "vpc_id" {
  value = module.project.vpc_id
}

output "vpc_cidr" {
  value = module.project.vpc_cidr
}

output "public_subnet_ids" {
  value = module.project.public_subnet_ids
  
}

output "instance_ip" {
  value = module.project.instance_ip
}