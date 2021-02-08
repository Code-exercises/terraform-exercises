output "ip" {
  description = "Public IP"
  value = aws_instance.http_server_instance.public_ip
}

output "security_group_id" {
  value = aws_security_group.http_sg.id
}

output "ec2_instance_public_ip" {
  value = aws_instance.http_server_instance.public_ip
}