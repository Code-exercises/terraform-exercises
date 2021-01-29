provider "aws" {
  region = "eu-central-1"
}

variable "http_port" {
  default = 8080
  description = "HTTP port for servers"
  type = number
}

resource "aws_security_group" "http_sg" {
  name = "http_sg"
  ingress {
    from_port = var.http_port
    to_port = var.http_port
    protocol = "tcp"
  }
}

data "aws_ami" "ubuntu"{
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_launch_configuration" "launch_-configuration" {
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.http_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World! My name is $(hostname)" > index.html
              nohup busybox httpd -f -p ${var.http_port}
              EOF
}
