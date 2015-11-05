#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags {
    Name = "demo-vpc"
  }
}
#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "demo-vpc-igw" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  tags {
    Name = "demo-vpc-igw"
  }
}
#--------------------------------------------------------------
# Subnets
#--------------------------------------------------------------
resource "aws_subnet" "demo-vpc-dmz-1a" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags {
    Name = "demo-vpc-dmz-1a"
  }
}
resource "aws_subnet" "demo-vpc-dmz-1c" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  cidr_block = "10.0.20.0/24"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags {
    Name = "demo-vpc-dmz-1c"
  }
}
resource "aws_subnet" "demo-vpc-frontend-1a" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  cidr_block = "10.0.30.0/24"
  availability_zone = "ap-northeast-1a"
  tags {
    Name = "demo-vpc-frontend-1a"
  }
}
resource "aws_subnet" "demo-vpc-frontend-1c" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  cidr_block = "10.0.40.0/24"
  availability_zone = "ap-northeast-1c"
  tags {
    Name = "demo-vpc-frontend-1c"
  }
}
resource "aws_subnet" "demo-vpc-backend-1a" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  cidr_block = "10.0.50.0/24"
  availability_zone = "ap-northeast-1a"
  tags {
    Name = "demo-vpc-backend-1a"
  }
}
resource "aws_subnet" "demo-vpc-backend-1c" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  cidr_block = "10.0.60.0/24"
  availability_zone = "ap-northeast-1c"
  tags {
    Name = "demo-vpc-backend-1c"
  }
}

#--------------------------------------------------------------
# Routes Table
#--------------------------------------------------------------
resource "aws_route_table" "demo-vpc-public-rt" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-vpc-igw.id}"
  }
  tags {
    Name = "demo-vpc-public-rt"
  }
}
resource "aws_route_table" "demo-vpc-nat-rt" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat-sv.id}"
  }
  tags {
    Name = "demo-vpc-nat-rt"
  }
}
resource "aws_route_table_association" "demo-vpc-public-rta-1a" {
  subnet_id = "${aws_subnet.demo-vpc-dmz-1a.id}"
  route_table_id = "${aws_route_table.demo-vpc-public-rt.id}"
}
resource "aws_route_table_association" "demo-vpc-public-rta-1c" {
  subnet_id = "${aws_subnet.demo-vpc-dmz-1c.id}"
  route_table_id = "${aws_route_table.demo-vpc-public-rt.id}"
}
resource "aws_route_table_association" "demo-vpc-nat-rta-1a" {
  subnet_id = "${aws_subnet.demo-vpc-frontend-1a.id}"
  route_table_id = "${aws_route_table.demo-vpc-nat-rt.id}"
}
resource "aws_route_table_association" "demo-vpc-nat-rta-1c" {
  subnet_id = "${aws_subnet.demo-vpc-frontend-1c.id}"
  route_table_id = "${aws_route_table.demo-vpc-nat-rt.id}"
}
