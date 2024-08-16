#this is for AWS S3 bucket

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.54.1"
    }
  }
}


provider "aws" {
    region = "ap-south-1"
    
  # Configuration options
}

resource "aws_instance" "myserver" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
      Name = "SampleServer"
    }
}


#after saving this use commands terraform init, terraform validate, terraform plan, terraform apply