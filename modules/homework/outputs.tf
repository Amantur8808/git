output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets.id
  
}

output "instance_ip" {
  value = aws_eip.elastic_ip.public_ip
}