#--------------------------------------------------------------
# AWS Common settings
#--------------------------------------------------------------
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "ap-northeast-1"
}
variable "ssh_allow_ip" {}

#--------------------------------------------------------------
# EC2 settings(ROOT DEVICE)
#--------------------------------------------------------------
variable "ami_id" {}
variable "nat_ami_id" {}
variable "keyname" {}
variable "ami_backup_generation" {}

#--------------------------------------------------------------
# EBS settings (ROOT DEVICE)
#--------------------------------------------------------------
variable "ebs_root_volume_type" {}
variable "ebs_root_volume_size" {}
variable "ebs_root_delete_on_termination" {}

#--------------------------------------------------------------
# EBS settings (BLOCK DEVICE)
#--------------------------------------------------------------
#variable "ebs_device_name" {}
#variable "ebs_device_volume_type" {}
#variable "ebs_device_volume_size" {}
#variable "ebs_device_delete_on_termination" {}

#--------------------------------------------------------------
# RDS settings
#--------------------------------------------------------------
variable "rds_postgresql_engine_version" {}
variable "rds_db_name" {}
variable "rds_master_username" {}
variable "rds_master_password" {}
variable "rds_backup_retention_period" {}
variable "rds_backup_window" {}
variable "rds_maintenance_window" {}

#--------------------------------------------------------------
# ElastiCache settings
#--------------------------------------------------------------
variable "cache_engine_name" {}
variable "cache_engine_version" {}
variable "cache_backup_retention_period" {}
variable "cache_backup_window" {}
variable "cache_maintenance_window" {}
