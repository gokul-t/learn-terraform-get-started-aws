
output "main" {
  description = "The VPC"
  value       = aws_vpc.main
}

output "public_subnets" {
  description = "List of public subnets"
  value       = aws_subnet.public
}
