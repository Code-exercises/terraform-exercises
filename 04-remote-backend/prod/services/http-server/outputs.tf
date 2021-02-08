output "url" {
  description = "HTTP server URL"
  value = "http://${aws_instance.http_server_instance.public_ip}:${var.port}"
}