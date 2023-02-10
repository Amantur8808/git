variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "ami" {
  description = "AMI"
  type = string
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "user_data" {
  type = any
  
}

variable "cidr_blocks" {
  default = "10.0.1.0/24"
}

variable "cidr_block" {
  default = "0.0.0.0/0"
}


