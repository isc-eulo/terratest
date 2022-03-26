//definicion de provider
terraform {
    required_version = ">= 0.15"
 required_providers {
     aws = {
         source = "hashicorp/aws"
         version = "~> 3.28"
     }
     random = {//este genera el random
         source = "hashicorp/random"
         version = "~> 3.0"
     }
 }
}
