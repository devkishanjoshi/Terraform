provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secretkey
}


resource "aws_security_group" "allow_tls_1" {
  name        = "allow_tls_1"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-8e3429e6"

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name =      var.key_name
  
  # To use above created security group in this resource 
  security_groups  = [aws_security_group.allow_tls_1.name]


 connection {
   user = "ec2-user"
   private_key= file(var.private_key_path)
   password=""
   type="ssh"
   host = self.public_ip
}
 provisioner "remote-exec" {
   inline = [
     "sudo yum install httpd -y",
     "sudo systemctl start httpd"
   ]
 }

}




