provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {}

data "aws_vpc" "default" {
  id = var.vpc_id
}

//crear llave
resource "tls_private_key" "key" {
 algorithm = "RSA"
}

//definir llave  privada
resource "local_file" "private_key" {
 filename          = "${path.module}/key1.pem"
 sensitive_content = tls_private_key.key.private_key_pem
 file_permission   = "0400"
}
//crear llave en aws
resource "aws_key_pair" "key_pair" {
 key_name   = "key1"
 public_key = tls_private_key.key.public_key_openssh
}
//inicio grupo de seguridad
resource "aws_security_group" "allow_ssh" {
 vpc_id = data.aws_vpc.default.id


//ingresa por el pt 22
 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["187.189.145.165/32"]// esta es la unica ip q puede acceder
 }

//ingresa solo el puerto 80
 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["187.189.145.165/32"] // esta es la unica ip q puede acceder
 }

 ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["187.189.145.165/32"]
  }


//sal por cualquier puerto y direccion
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
//inicio grupo de seguridad


resource "aws_instance" "instanciaweb" {
  ami                    = "ami-04505e74c0741db8d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.key_pair.key_name
 
  tags = {
    Name = "instanciaweb"
  }

//ejecutar conexion remora mediante ssh
provisioner "remote-exec" {
    inline = [//comandos ajecutar
      "sudo apt update -y",
      "sudo apt install -y software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible",
  
      "sudo mkdir /nas",
      "sudo chmod 775 /nas"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = tls_private_key.key.private_key_pem
    }
  }//fin 
// ejecutar scrip locarl cargar en local
provisioner "local-exec" {
    command = "ping -n 10 ${aws_instance.instanciaweb.public_ip}"
  }

}//fin resouser

output "PrivateIP" { 
    value = "${aws_instance.instanciaweb.private_ip}"
}
output "PublicIP" {
    value = "${aws_instance.instanciaweb.public_ip}"
}
