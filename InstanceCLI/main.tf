//config terraform cloud
terraform {
  cloud {
    organization = "isc-drm"

    workspaces {
      name = "InstanceCLI"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}



//credencial
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

provider "aws"{ 
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

//crear instancia
resource "aws_instance" "InstanceCLI" {
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags = {
    Name = "InstanceCLI"
  }
}
