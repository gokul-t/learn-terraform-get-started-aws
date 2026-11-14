output "public_ip" {
  description = "The public IP of alb"
  value       = aws_lb.alb.dns_name
}
