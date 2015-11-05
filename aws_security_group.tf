#####################################
# Security Group Settings
#####################################
resource "aws_security_group" "demo_elb_sg" {
  name = "demo_elb_sg"
  description = "DEMO ELB SG"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "demo_elb_sg"
  }
}
resource "aws_security_group" "demo_web_sg" {
  name = "demo_web_sg"
  description = "DEMO WEB SG"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.demo_elb_sg.id}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.ssh_sg.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "demo_web_sg"
  }
}
resource "aws_security_group" "demo_db_sg" {
  name = "demo_db_sg"
  description = "DEMO DB SG"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.demo_web_sg.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "demo_db_sg"
  }
}
resource "aws_security_group" "demo_cache_sg" {
  name = "demo_cache_sg"
  description = "DEMO CACHE SG"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  ingress {
    from_port = 11211
    to_port = 11211
    protocol = "tcp"
    security_groups = ["${aws_security_group.demo_web_sg.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "demo_cache_sg"
  }
}
resource "aws_security_group" "ssh_sg" {
  name = "ssh_sg"
  description = "SSH SG"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ssh_allow_ip}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "ssh_sg"
  }
}
resource "aws_security_group" "nat_sg" {
  name = "nat_sg"
  description = "NAT SG"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.ssh_sg.id}"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${aws_subnet.demo-vpc-frontend-1a.cidr_block}"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${aws_subnet.demo-vpc-frontend-1c.cidr_block}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "nat_sg"
  }
}
