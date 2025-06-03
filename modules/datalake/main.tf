# EC2 Instances
resource "aws_instance" "datalake" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[1]
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_groups_id_ec2]
  user_data = templatefile("${path.module}/user-data.sh", {})
  tags = {
    Name = "datalake"
  }
}