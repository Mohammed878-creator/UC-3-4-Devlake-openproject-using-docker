# EC2 Instances
resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_groups_id_ec2]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              curl -fsSL https://get.docker.com -o install-docker.sh
              sudo sh install-docker.sh
              sudo usermod -aG docker ubuntu
              sudo docker run -d -p 80:80 -e OPENPROJECT_SECRET_KEY_BASE=secret -e OPENPROJECT_HTTPS=false openproject/openproject:15.4.1
            EOF
  tags = {
    Name = "app-instance-1"
  }
}