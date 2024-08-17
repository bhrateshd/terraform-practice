provider "aws" {
    region = "ap-south-1"
  
}

import {
  id = "" #add aws instance id here which you want to import

  to = aws_instance.example
}