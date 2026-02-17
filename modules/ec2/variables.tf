
variable "user_data_script" {
  description = "User data script to initialize the EC2 instance"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html
                EOF

}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone where the EC2 instance will be launched"
  type        = string
}
