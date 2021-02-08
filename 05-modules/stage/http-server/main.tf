terraform {
  backend "s3" {
    key = "stage/http-server/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "http-server" {
  source = "../../modules/http-server"
  instance_type = "t2.micro"
  port = var.http_port
}

resource "aws_security_group_rule" "allow_8080_ingress" {
  from_port = var.additional_http_port
  protocol = "tcp"
  security_group_id = module.http-server.security_group_id
  to_port = var.additional_http_port
  cidr_blocks = ["0.0.0.0/0"]
  type = "ingress"
}