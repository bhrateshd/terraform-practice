provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "bserver" {
    instance_type = "t2.micro"
    ami = "ami-0ad21ae1d0696ad58"
  
}

resource "aws_s3_bucket" "mybucket" {
    bucket = "bhrateshd-terraform-bucket"
    
  
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}