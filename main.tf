provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0d2614eafc1b0e4d2"
  instance_type = var.instance_type

  tags = {
    Name = "Demo"
  }
}