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
}

resource "aws_security_group_rule" "inbound_http_rule" {
  type = "ingress"
  from_port = var.port
  to_port = var.port
  protocol = "tcp"
  security_group_id = aws_security_group.http_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
  vars = {
    port = var.port
  }
}

resource "aws_instance" "http_server_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.http_sg.id]
  user_data = data.template_file.user_data.rendered
  tags = {
    Name = "http-server"
  }
}