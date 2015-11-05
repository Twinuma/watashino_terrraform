#--------------------------------------------------------------
# Elastic Load Balancer
#--------------------------------------------------------------
resource "aws_elb" "demo-elb" {
  name = "demo-elb"
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 5
    target = "HTTP:80/"
    interval = 60
  }

  security_groups = ["${aws_security_group.demo_elb_sg.id}"]
  instances = ["${aws_instance.demo-sv.id}"]
  subnets = ["${aws_subnet.demo-vpc-frontend-1a.id}", "${aws_subnet.demo-vpc-frontend-1c.id}"]

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "demo-elb"
  }
}
