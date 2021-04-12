variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "amis" {
	description = "amis by region"
	default = {
	   us-east-1 = "ami-0739f8cdb239fe9ae"
	   us-east-2 = "ami-0ebc8f6f580a04647"
	}
}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "apr2021_subnet_1_name" {}
variable "apr2021_subnet_2_name" {}
variable "apr2021_subnet_3_name" {}
variable "apr2021-subnet-1_cidr" {}
variable "apr2021-subnet-2_cidr" {}
variable "apr2021-subnet-3_cidr" {}
variable "IGW_name" {}
variable "routetable_name" {}
variable "allow_all" {}
variable "instance_type" {}
variable "key_name" {}
variable "server_name" {}
variable "availability_zones" {
  description = "run the ec2 instances in this availability zones"
  type = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}