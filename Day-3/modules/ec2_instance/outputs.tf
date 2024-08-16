output "public-ip-address" {
    value = aws_instance.jenkinsmaster.public_ip
  
}