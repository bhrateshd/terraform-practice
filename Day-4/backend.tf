terraform {
  backend "s3" {
    bucket = "bhrateshd-terraform-bucket"
    region = "ap-south-1"
    key = "bhratesh/terraform.tfstate"
    dynamodb_table = "terraform_lock"   #first create s3 and dynamodb for that only run main.tf file by commenting backend fileand then after that run backend.tf by uncommenting
    
  }
}
