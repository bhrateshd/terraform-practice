provider "aws" {
    region = "ap-south-1"
    
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_value = "add youe ami value"
    instance_type_value = "t2.micro"
    subnet_id_value = "subnet-jsdug78fd78"
  
}