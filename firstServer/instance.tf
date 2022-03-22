// proveedor
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
//credenciales
provider "aws" {
access_key = "xxxxxxxx"
secret_key = "xxxxxxx"
region = "us-east-2"
}

//para crear una instancia EC2
resource "aws_instance" "hello-instance" {
  ami = "ami-0fb653ca2d3203ac1"//imagen del SO
  instance_type = "t2.micro"//tipo recursos ram y pcu
  tags = {
    Name = "hello-instance"
  }
}
