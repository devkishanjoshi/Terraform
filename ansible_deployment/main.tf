provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}


resource "aws_instance" "web" {
  ami              = "ami-052c08d70def0ac62"
  instance_type    = "t2.micro"
  key_name         = "terraform"
  security_groups  = ["default"] 

  tags = {
    Name = "HelloWorld"
  }

 connection {
   user = "ec2-user"
   private_key= file("/root/terraform/hello/terraform.pem")
   password=""
   type="ssh"
   host = self.public_ip
}

provisioner "remote-exec" {
    inline = ["sudo yum  install python36 -y"]
  }



  provisioner "local-exec" {
    command = "ansible-playbook -u ec2-user  -i '${self.public_ip},' --private-key terraform.pem  script.yml" 
  }

}














