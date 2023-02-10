#----------------------------------------------------------
# My Code
#
# 
#
# Code by Amantur Bolotbaev
#----------------------------------------------------------

provider "aws" {
  region = var.region
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.web_server.id
  vpc      = true
  associate_with_private_ip = "10.0.1.112"

  tags = {
    "Namee" = "MyNewIp"
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.webserver.id]
  subnet_id              = aws_subnet.public_subnets.id
  user_data = file(user_data.sh)
  private_ip = "10.0.1.112"
  
  tags = {
    Name = "WebServer - ${terraform.workspace}"
  }
}

   


data "aws_ami" "latest_ubuntu" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

resource "aws_security_group" "webserver" {
  name = "WebServer Security Group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/20"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-sg"
    Owner = "Bolotbaev Amantur"
  }
}




resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "New VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "New GateWay"
  }
}


resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.main.id
  cidr_block = var.cidr_blocks
  tags = {
    Name = "New Subnet"
  }
}


resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "New Route_Table"
  }
}

resource "aws_route_table_association" "note" {
  subnet_id = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.public_subnets.id
}




#==============================================================
