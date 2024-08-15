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
    ami = "ami-0ad21ae1d0696ad58"
    instance_type = "t2.micro"

    tags = {
      Name = "SampleServer"
    }
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket"
}

resource "aws_s3_object" "bucket-data" {
    bucket =  aws_s3_bucket.demo-bucket.bucket
    source = "./myfile.txt"
    key = "mydata.txt"
  
}


#after saving this use commands terraform init, terraform validate, terraform plan, terraform apply