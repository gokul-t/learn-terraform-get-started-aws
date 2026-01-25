locals {
  region = "us-east-1"
}

provider "aws" {
  region = local.region
}

resource "aws_iam_role" "ec2_access_role" {
  name = "aws_iam_role.ec2_access_role.name"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_readonly_attach" {
  role       = aws_iam_role.ec2_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_al2023"
  role = aws_iam_role.ec2_access_role.name
}

resource "aws_security_group" "web_access" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Caution: Allows access from anywhere
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Caution: Allows access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    # Pattern for Amazon Linux 2023 (x86_64)
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Generate a new RSA 4096 private key
resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key to a local .pem file
resource "local_sensitive_file" "pem_file" {
  filename        = "${path.module}/my-ec2-key.pem"
  content         = tls_private_key.ec2_ssh_key.private_key_pem
  file_permission = "0400" # Restricted read-only permission for SSH
}

# Register the public key with AWS
resource "aws_key_pair" "deployer" {
  key_name   = "my-ec2-key"
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name # Attaches the key
  vpc_security_group_ids = [aws_security_group.web_access.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  # User Data script to install and start a web server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "learn-terraform-get-started-aws"
  }
}
