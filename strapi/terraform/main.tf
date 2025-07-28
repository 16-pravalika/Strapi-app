provider "aws" {
  region = var.region
}

resource "aws_instance" "strapi" {
  ami           = var.ami # Amazon Linux 2 (Ohio region)
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.strapi_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              exec > /var/log/user-data.log 2>&1

              echo ">>> Updating packages"
              apt-get update -y

              echo ">>> Installing Docker"
              apt-get install -y docker.io

              echo ">>> Starting Docker service"
              systemctl start docker
              systemctl enable docker

              echo ">>> Removing old Strapi container if exists"
              docker rm -f strapi || true

              echo ">>> Pulling Strapi Docker image"
              docker pull 16pravalikam/strapi-app:${var.image_tag}

              echo ">>> Running Strapi container"
              docker run -d \\
                --name strapi-app \\
                -p 1337:1337 \\
                --restart unless-stopped \\
                16pravalikam/strapi-app:${var.image_tag}

              echo ">>> Done setting up Strapi"
              EOF

  tags = {
    Name = "Strapi-Ins"
  }
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-security-group"
  description = "Allow HTTP and SSH access"

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    description = "HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

