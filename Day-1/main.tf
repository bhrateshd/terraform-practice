provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_instance" "myserver" {
  ami = "#add ami id "
  instance_type = "t2.micro" 
}