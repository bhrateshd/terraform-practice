variable "ami_value" {
    description = "Value for the AMI"
}

variable "instance_type_value" {
    description = " Value for instance type"
  
}

variable "subnet_id_value" {
    description = "value for subnet id"
  
}


provider "aws" {
    region = "ap-south-1"
    
}

resource "aws_instance" "jenkinsmaster" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id_value

  
}