output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "security_group_ec2" {
  value = aws_security_group.ec2.id
}

output "vpc_id_details" {
  value = aws_vpc.demo-vpc-uc3-uc4.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}

output "security_group_alb" {
  value = aws_security_group.uc3-uc4-alb.id
}