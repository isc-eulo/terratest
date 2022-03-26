terraform {
  cloud {
    organization = "isc-drm"

    workspaces {
      name = "dealer"
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
  region = "us-east-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

/*------------bucket------------*/

resource "aws_s3_bucket" "isctestab1" {
  bucket = "my-iscdrm-testab1"

  tags = {
    Name        = "my-iscdrm-testab1"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_acl" "exampleab1" {
  bucket = aws_s3_bucket.isctestab1.id
  acl    = "private"
}


/*------------content------------*/

resource "aws_s3_bucket_object" "objectab1" {
  bucket = aws_s3_bucket.isctestab1.bucket
  key    = "index.html"
  acl = "public-read"
  content = var.content
  content_type = "text/html"
}
variable content {
    type = string
    default = "Hola mundo"
  
}
variable bucket {
    type = string
    default = "welcome"
  
}