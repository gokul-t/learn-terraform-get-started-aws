
module "vpc" {
  source = "../modules/vpc"
}

resource "aws_efs_file_system" "efs" {
  creation_token = "my-efs"
  encrypted      = true

  tags = {
    Name = "MyEFS"
  }
}

resource "aws_efs_mount_target" "mount" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = element(module.vpc.public_subnets, 0).id # Place in the first public subnet
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_security_group" "efs_sg" {
  name   = "efs-sg"
  vpc_id = module.vpc.main.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  user_data_script = <<-EOF
    #!/bin/bash
    yum install -y amazon-efs-utils
    mkdir -p /mnt/efs
    mount -t efs ${aws_efs_file_system.efs.id}:/ /mnt/efs
  EOF
}

module "ec2" {
  source                    = "../modules/ec2"
  vpc_id                    = module.vpc.main.id
  subnet_id                 = element(module.vpc.public_subnets, 0).id                # Place in the first public subnet
  availability_zone         = element(module.vpc.public_subnets, 0).availability_zone # Place in the first AZ of the VPC
  ec2_instance_profile_name = null
  user_data_script          = local.user_data_script
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
  key_name   = "my-ec2-key-2"
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

resource "aws_instance" "web_server2" {
  ami                    = module.ec2.web_server.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name # Attaches the key
  vpc_security_group_ids = [module.ec2.web_access.id]
  # User Data script to install and start a web server
  subnet_id         = element(module.vpc.public_subnets, 0).id                # Place in the first public subnet
  availability_zone = element(module.vpc.public_subnets, 0).availability_zone # Place in the first AZ of the VPC
  user_data         = local.user_data_script
  tags = {
    Name = "web-server-2"
  }
}
