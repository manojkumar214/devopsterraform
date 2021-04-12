provider "aws" {
	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
	region = var.aws_region
	profile = "default"
}

resource "aws_vpc" "default" {
	cidr_block = var.vpc_cidr
	enable_dns_hostnames = "true"

	tags = {
	  Name = var.vpc_name
	}
}

resource "aws_subnet" "apr2021-subnet-1" {
	cidr_block = var.apr2021-subnet-1_cidr
	vpc_id = aws_vpc.default.id
	availability_zone = "us-east-1a"

	tags = {
	  Name = var.apr2021_subnet_1_name
	}
}

resource "aws_subnet" "apr2021-subnet-2" {
	cidr_block = var.apr2021-subnet-2_cidr
	vpc_id = aws_vpc.default.id
	availability_zone = "us-east-1b"

	tags = {
	  Name = var.apr2021_subnet_2_name
	}
}

resource "aws_subnet" "apr2021-subnet-3" {
	cidr_block = var.apr2021-subnet-3_cidr
	vpc_id = aws_vpc.default.id
	availability_zone = "us-east-1b"

	tags = {
	  Name = var.apr2021_subnet_2_name
	}
}

resource "aws_internet_gateway" "default" {
	vpc_id = aws_vpc.default.id

	tags = {
	  Name = var.IGW_name
	}
}

resource "aws_route_table" "apr2021-route-table" {
	vpc_id = aws_vpc.default.id

	route {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.default.id
	}

	tags = {
	  Name = var.routetable_name
	}
}

resource "aws_route_table_association" "apr2021-route-table" {
	route_table_id = aws_route_table.apr2021-route-table.id
	subnet_id = aws_subnet.apr2021-subnet-1.id
}

resource "aws_route_table_association" "apr2021-route-table" {
	route_table_id = aws_route_table.apr2021-route-table.id
	subnet_id = aws_subnet.apr2021-subnet-2.id
}

resource "aws_route_table_association" "apr2021-route-table" {
	route_table_id = aws_route_table.apr2021-route-table.id
	subnet_id = aws_subnet.apr2021-subnet-3.id
}

resource "aws_security_group" "allow_all" {
	name = "allow_all"
	vpc_id = aws_vpc.default.id
	description = "Allow all inbound traffic"

	ingress {
	  from_port = 0
	  to_port = 0
	  protocal = "-1"
	  cidr_blocks = "0.0.0.0/0"
	}

	egress {
	  from_port = 0
	  to_port = 0
	  protocal = "-1"
	  cidr_blocks = "0.0.0.0/0"
	}

}

resource "aws_instance" "web-1" {
	instance_type = var.instance_type
	key_name = var.key_name
	ami_id = "ami-0739f8cdb239fe9ae"
	availability_zone = "us-east-1a"
	subnet_id = aws_subnet.apr2021-subnet-1.id
	vpc_security_group_ids = [aws_security_group.allow_all.id]
	associate_public_ip_address = "true"

	tags = {
	  Name = var.server_name
	}
}