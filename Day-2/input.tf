resource "aws_instance" "myserver" {
  ami = var.ami_id
  instance_type = var.instance_type
}