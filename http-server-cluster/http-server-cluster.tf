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
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_launch_configuration" "asg_launch_configuration" {
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.http_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World? My name is $(hostname)" > index.html
              nohup busybox httpd -f -p ${var.http_port}
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_vpc" "vpc" {
  default = true
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = data.aws_subnet_ids.subnet_ids.ids
  launch_configuration = aws_launch_configuration.asg_launch_configuration.name
  name_prefix = "${aws_launch_configuration.asg_launch_configuration.name}--"

  health_check_type = "ELB"
  target_group_arns = [aws_alb_target_group.alb_tg.arn]

  min_size = 3
  max_size = 10

  tag {
    key = "Name"
    value = "terraform_asg"
    propagate_at_launch = true
  }
}

resource "aws_alb" "alb" {
  name = "alb"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.subnet_ids.ids
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = 80
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
}

resource "aws_security_group" "alb_sg" {
  name = "alb_sg"
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb_target_group" "alb_tg" {
  name = "alb-tg"
  port = var.http_port
  protocol = "HTTP"
  vpc_id = data.aws_vpc.vpc.id
  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_alb_listener.alb_listener.arn
  priority = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_tg.arn
  }
}

output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}