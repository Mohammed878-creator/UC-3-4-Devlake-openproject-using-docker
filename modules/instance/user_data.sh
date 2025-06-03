# #!/bin/bash
# sudo apt-get update
# sudo apt-get install -y docker.io docker-compose

# sudo mkdir -p /opt/openproject
# sudo cd /opt/openproject

# sudo tee cat <<EOF > docker-compose.yml
# version: '3'
# services:
#   openproject:
#     image: openproject/community:latest
#     restart: always
#     ports:
#       - "8080:80"
#     environment:
#       - OPENPROJECT_HTTPS=false
#     volumes:
#       - openproject_data:/var/openproject
# volumes:
#   openproject_data:
# EOF

# sudo docker-compose up -d

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    curl -fsSL https://get.docker.com -o install-docker.sh
    sudo sh install-docker.sh
    sudo usermod -aG docker ubuntu
    docker run -d -p 80:80 \
     -e OPENPROJECT_SECRET_KEY_BASE=secret \
     -e OPENPROJECT_HTTPS=false \
     openproject/openproject:15.4.1
  EOF