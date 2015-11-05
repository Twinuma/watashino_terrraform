#--------------------------------------------------------------
# RDS Instance for MySQL
#--------------------------------------------------------------
resource "aws_db_instance" "demo-rds" {
  identifier = "demo-db"
  allocated_storage = 10
  engine = "mysql"
  engine_version = "${var.rds_mysql_engine_version}"
  instance_class = "db.t2.micro"
  name = "${var.rds_db_name}"
  username = "${var.rds_master_username}"
  password = "${var.rds_master_password}"
  multi_az = 0
  backup_retention_period = "${var.rds_backup_retention_period}"
  backup_window = "${var.rds_backup_window}"
  maintenance_window = "${var.rds_maintenance_window}"
  vpc_security_group_ids = ["${aws_security_group.demo_db_sg.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.demo-subnet-group.id}"
  parameter_group_name = "${aws_db_parameter_group.demo-mysql.id}"
  tags {
    Name = "demo-db"
  }
}
#--------------------------------------------------------------
# RDS Parameter Group
#--------------------------------------------------------------
resource "aws_db_parameter_group" "demo-mysql" {
  name = "demo-parameter-group"
  family = "mysql5.6"
  description = "RDS customize parameter group"
  parameter {
    name = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name = "character_set_client"
    value = "utf8mb4"
  }
  parameter {
    name = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name = "character_set_results"
    value = "utf8mb4"
  }
  parameter {
    name = "collation_connection"
    value = "utf8_general_ci"
  }
  parameter {
    name = "general_log"
    value = "1"
  }
  parameter {
    name = "slow_query_log"
    value = "1"
  }
  parameter {
    name = "long_query_time"
    value = "3"
  }
}
#--------------------------------------------------------------
# RDS Subnet Group
#--------------------------------------------------------------
resource "aws_db_subnet_group" "demo-subnet-group" {
  name = "demo-subnet-group"
  description = "main group of subnets"
  subnet_ids = ["${aws_subnet.demo-vpc-backend-1a.id}", "${aws_subnet.demo-vpc-backend-1c.id}"]
  tags {
    Name = "DB subnet group"
  }
}
