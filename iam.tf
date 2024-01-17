terraform {
  required_version = ">=1.3.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0" # Specify the version constraint according to your requirements
    }
  }
}
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIASVCVN2RKXVDUEIZ7"
  secret_key = "dKIWrOMK3H2d+ua5g5VPl56rwVw/XrrJek1+LvT4"
}
resource "aws_vpc" "muhsina_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "muhsina"
  }
}
resource "aws_subnet" "muhsina_sub" {
  vpc_id            = aws_vpc.muhsina_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1b" # Change this to your desired availability zone
  tags = {
    Name = "muhsina_sub_pri"
  }
}
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id              = aws_vpc.muhsina_vpc.id
  service_name        = "com.amazonaws.ap-south-1.s3"
  route_table_ids     = [aws_vpc.muhsina_vpc.main_route_table_id]
  security_group_ids  = [] # You can specify security groups if needed
  private_dns_enabled = false
  tags = {
    Name = "S3Endpoint"
  }
}
