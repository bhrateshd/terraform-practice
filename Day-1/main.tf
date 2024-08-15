terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.62.0"
    }
  }
}

provider "aws" {
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