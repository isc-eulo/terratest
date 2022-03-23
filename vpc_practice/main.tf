provider "aws" {
  region = var.aws_region  
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
