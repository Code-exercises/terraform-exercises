terraform {
  backend "s3" {
    key = "prod/services/http-server/terraform.tfstate"
  }
}


provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  owners = ["099720109477"] # AWS account ID of Canonical
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_security_group" "http_sg"{
  name = "http-security-group"
  ingress {
    from_port = var.port
    to_port = var.port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "http_server_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.port} &
              EOF
  tags = {
    Name = "http-server"
  }
}
