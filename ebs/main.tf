module "ec2" {
  source = "../ec2"
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
