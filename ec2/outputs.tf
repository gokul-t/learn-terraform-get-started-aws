output "public_ip" {
  description = "The public IP address of the web server"
  value       = module.ec2.web_server.public_ip
}
