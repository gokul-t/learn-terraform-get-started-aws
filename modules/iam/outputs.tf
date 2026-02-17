output "ec2_instance_profile" {
  value       = aws_iam_instance_profile.ec2_profile
  description = "The IAM instance profile for EC2 access"
}
