terraform {
  backend "s3" {
	bucket = "s3backend-test-s3qqe06vv-state-bucket"
	key="state/statevpc"
	region ="us-west-1"
  }
}


resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
      //referencia de variabke string para vpc
      Name = var.vpc_name
  }
}
	resource "aws_subnet" "subnet1" { 

	    vpc_id = aws_vpc.vpc1.id // identificador de vpc

	    cidr_block = var.subnet_cidr[0] //recopera valor de vaariable
	    availability_zone = var.az[1]//recopera valor de variable
	    tags = { 
	        Name = var.subnet_name[1]//recopera valor de variable
	    }   
	}

	resource "aws_subnet" "subnet2" { 

	    vpc_id = aws_vpc.vpc1.id // identificador de vpc

	    cidr_block = var.subnet_cidr[1] //recopera valor de vaariable
	    availability_zone = var.az[1]//recopera valor de variable
	    tags = { 
	        Name = var.subnet_name[2]//recopera valor de variable
	    }   
	}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  filename          = "${path.module}/ansible-key.pem"
  sensitive_content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "ansible-key-testab1"
  public_key = tls_private_key.key.public_key_openssh
}
