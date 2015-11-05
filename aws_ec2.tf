#--------------------------------------------------------------
# EC2 Instance
#--------------------------------------------------------------
resource "aws_instance" "demo-sv" {
  instance_type = "t2.micro"
  ami = "${var.ami_id}"
  count = 1
  availability_zone = "ap-northeast-1a"
  key_name = "${var.keyname}"
  subnet_id = "${aws_subnet.demo-vpc-frontend-1a.id}"
  vpc_security_group_ids = ["${aws_security_group.demo_web_sg.id}"]
  user_data = "${file("web_setting.txt")}"
  associate_public_ip_address = 1
  monitoring  = 1
  iam_instance_profile = "${aws_iam_instance_profile.demo_profile.id}"
  root_block_device {
    volume_type = "${var.ebs_root_volume_type}"
    volume_size = "${var.ebs_root_volume_size}"
    delete_on_termination = "${var.ebs_root_delete_on_termination}"
  }
  tags {
    Name = "demo-sv"
  }
}
resource "aws_instance" "ssh-bastion" {
  instance_type = "t2.micro"
  ami = "${var.ami_id}"
  count = 1
  availability_zone = "ap-northeast-1a"
  key_name = "${var.keyname}"
  subnet_id = "${aws_subnet.demo-vpc-dmz-1a.id}"
  vpc_security_group_ids = ["${aws_security_group.ssh_sg.id}"]
  user_data = "${file("ssh_setting.txt")}"
  # iam_instance_profile = "${aws_iam_instance_profile.demo_profile.id}"
  tags {
    Name = "ssh-bastion"
  }
}
resource "aws_instance" "nat-sv" {
  instance_type = "t2.micro"
  ami = "${var.nat_ami_id}"
  count = 1
  availability_zone = "ap-northeast-1c"
  key_name = "${var.keyname}"
  subnet_id = "${aws_subnet.demo-vpc-dmz-1c.id}"
  vpc_security_group_ids = ["${aws_security_group.nat_sg.id}"]
  source_dest_check = 0
  tags {
    Name = "nat-sv"
  }
}
#--------------------------------------------------------------
# Elastic IP
#--------------------------------------------------------------
resource "aws_eip" "nat_eip" {
  instance = "${aws_instance.nat-sv.id}"
  vpc = true
}
resource "aws_eip" "ssh_eip" {
  instance = "${aws_instance.ssh-bastion.id}"
  vpc = true
}
