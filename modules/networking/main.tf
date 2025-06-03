#Provider
provider "aws" {
  region = var.region
}
 
# VPC and Networking
resource "aws_vpc" "demo-vpc-uc3-uc4" {
cidr_block = var.vpc_cidr
  tags = {
    Name = "demo-vpc-uc3-uc4"
  }
}

#Creation Internet Gateway
resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.demo-vpc-uc3-uc4.id
  tags = {
    Name = "demo-vpc-uc3-uc4-igw"
  }
}

#Creation Public Subnet
resource "aws_subnet" "public_subnet" {
  count             = 2
  vpc_id = aws_vpc.demo-vpc-uc3-uc4.id
  cidr_block        = element(var.public_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

#Assigning Internet to Internet Gateway in Routes
resource "aws_route_table" "public_routes" {
vpc_id = aws_vpc.demo-vpc-uc3-uc4.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Adding Public subnets in Subnet Association
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_routes.id
}

# Creating Security Group from ALB 
resource "aws_security_group" "uc3-uc4-alb" {
  name   = "alb-sg"
  vpc_id = aws_vpc.demo-vpc-uc3-uc4.id
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "uc3-uc4-alb"
  }
}


#Creating Security Group for Ec2 Instance
resource "aws_security_group" "ec2" {
  name   = "ec2"
  vpc_id = aws_vpc.demo-vpc-uc3-uc4.id
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.uc3-uc4-alb.id]
  }

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    security_groups = [aws_security_group.uc3-uc4-alb.id]
  }

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "uc3-uc4-ec2"
  }
}