output "ip" {
  description = "Public IP"
  value = aws_instance.http_server_instance.public_ip
}