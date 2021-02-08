provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # AWS account ID of Canonical
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "ec2"{
  ami = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}
