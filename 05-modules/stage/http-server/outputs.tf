output "url" {
  description = "HTTP server URL"
  value = "http://${module.http-server.ec2_instance_public_ip}:${var.http_port}"
}