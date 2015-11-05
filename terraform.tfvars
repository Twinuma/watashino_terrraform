#--------------------------------------------------------------
# AWS Common settings
#--------------------------------------------------------------
ssh_allow_ip = "192.168.10.2/32"

#--------------------------------------------------------------
# EC2 settings
#--------------------------------------------------------------
ami_id = "ami-383c1956"
nat_ami_id = "ami-11dc2a11"
keyname = "demo_key"
ami_backup_generation = "3"

#--------------------------------------------------------------
# EBS settings (ROOT DEVICE)
#--------------------------------------------------------------
ebs_root_volume_type = "gp2"
ebs_root_volume_size = "50"
ebs_root_delete_on_termination = "true"

#--------------------------------------------------------------
# EBS settings (BLOCK DEVICE)
#--------------------------------------------------------------
#ebs_device_name = "/dev/xvdb"
#ebs_device_volume_type = "gp2"
#ebs_device_volume_size = "50"
#ebs_device_delete_on_termination = "true"

#--------------------------------------------------------------
# RDS settings for MySQL
#--------------------------------------------------------------
rds_mysql_engine_version = "5.6.23"
rds_db_name = "mydb"
rds_master_username = "foo"
rds_master_password = "2kKtmCREnBdD"
rds_backup_retention_period = "3"
rds_backup_window = "09:19-09:49"
rds_maintenance_window = "fri:08:22-fri:08:52"

#--------------------------------------------------------------
# ElastiCache settings
#--------------------------------------------------------------
cache_engine_name = "redis"
cache_engine_version = "2.8.22"
cache_backup_retention_period = "3"
cache_backup_window = "09:19-10:19"
cache_maintenance_window = "fri:08:22-fri:09:22"
