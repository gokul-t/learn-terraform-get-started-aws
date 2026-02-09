output "web_server" {
  description = "The web server instance"
  value       = aws_instance.web_server
}
output "instance_public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

