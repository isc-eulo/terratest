provider "aws" {
  region = "us-east-1"
}
//se setean las variables de vpc/variables
module "vpc" {
    source = "./vpc" //se importa la carpeta vpc
    vpcname = "vpc_module1"
    vpc_cidr = "19.82.0.0/16"
    az = "us-east-1a"
    subnet_cidr = "19.82.1.0/24"
    subnet_names = "subnet1a"
    ec2_private_ip = ["19.82.1.82"] //se asiga la ip estatica para q queda fija


}

module "ec2" {//se setan variables de ec2/variables
    source = "./ec2"// se importa la carpeta ec2
    ec2ami = "ami-08e4e35cccc6189f4"
    ec2type = "t2.micro"
    ec2iface = module.vpc.ec2_network_interface
    ec2name = "ec2 name from module"
}
