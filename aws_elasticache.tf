#--------------------------------------------------------------
# ElastiCache for Redis
#--------------------------------------------------------------
resource "aws_elasticache_cluster" "demo-cache" {
  cluster_id = "demo-cluster"
  subnet_group_name = "${aws_elasticache_subnet_group.demo-subnet-group-cache.name}"
  engine = "${var.cache_engine_name}"
  engine_version = "${var.cache_engine_version}"
  node_type = "cache.t2.micro"
  num_cache_nodes = 1
  port = 11211
  maintenance_window = "${var.cache_maintenance_window}"
  security_group_ids = ["${aws_security_group.demo_cache_sg.id}"]
  parameter_group_name = "${aws_elasticache_parameter_group.demo-cache-params.id}"
  tags {
    Name = "demo-cluster"
  }
}
#--------------------------------------------------------------
# ElastiCache Subnet Group
#--------------------------------------------------------------
resource "aws_elasticache_subnet_group" "demo-subnet-group-cache" {
  name = "demo-subnet-group-cache"
  description = "Redis Subnet Group"
  subnet_ids = ["${aws_subnet.demo-vpc-backend-1a.id}", "${aws_subnet.demo-vpc-backend-1c.id}"]
}
#--------------------------------------------------------------
# ElastiCache Parameter Group
#--------------------------------------------------------------
resource "aws_elasticache_parameter_group" "demo-cache-params" {
  name = "demo-cache-params"
  family = "redis2.8"
  description = "Cache cluster customize param group"
}
