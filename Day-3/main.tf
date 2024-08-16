provider "aws" {
    region = "ap-south-1"
    
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_value = "ami-0ad21ae1d0696ad58"#add your ami id
    instance_type_value = "t2.micro"
    subnet_id_value = ""#add your subnet id
  
}