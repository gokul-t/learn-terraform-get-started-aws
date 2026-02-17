module "vpc" {
  source = "../modules/vpc"
}

module "ec2" {
  source                    = "../modules/ec2"
  vpc_id                    = module.vpc.main.id
  subnet_id                 = element(module.vpc.public_subnets, 0).id                # Place in the first public subnet
  availability_zone         = element(module.vpc.public_subnets, 0).availability_zone # Place in the first AZ of the VPC
  ec2_instance_profile_name = null
}

resource "aws_ebs_volume" "example" {
  availability_zone = module.ec2.web_server.availability_zone
  size              = 8
  tags = {
    Name = "example-volume"
  }
}

resource "aws_volume_attachment" "example" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.example.id
  instance_id = module.ec2.web_server.id
}
