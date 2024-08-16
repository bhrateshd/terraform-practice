
variable "ami_id" {
    description = "EC2 AMI ID"
    type = string
  
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t2.micro"
  
}