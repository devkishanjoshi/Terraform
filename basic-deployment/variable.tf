variable "region" {
  default = "ap-south-1"
}

variable "private_key_path"{}


variable "ami" {
  default = "ami-052c08d70def0ac62"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "terraform"
}

variable "security_group" {
  default = ["default"]
}

variable "access_key" {
  type=string 
}


variable "secretkey" {
  type=string

}

