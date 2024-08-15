provider "aws" {     # this is a provide on which we are gonna create a machine
    region = "ap-south-1"
    
  # Configuration options
}

resource "aws_instance" "myserver" {
    ami = "ami-0ad21ae1d0696ad58"
    instance_type = "t2.micro"

    tags = {
      Name = "SampleServer"
    }
}