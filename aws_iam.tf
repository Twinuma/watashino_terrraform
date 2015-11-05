#--------------------------------------------------------------
# IAM Role
#--------------------------------------------------------------
#--------------------------------------------------------------
# IAM Role
#--------------------------------------------------------------
resource "aws_iam_instance_profile" "demo_profile" {
    name = "demo_profile"
    roles = ["${aws_iam_role.demo_role.name}"]
}
resource "aws_iam_role" "demo_role" {
    name = "demo_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo_policy" {
    name = "demo_policy"
    role = "${aws_iam_role.demo_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "rds:*",
      "Resource": "arn:aws:rds:::*"
    },
    {
      "Effect": "Allow",
      "Action": "logs:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticache:*",
      "Resource": "arn:aws:elasticache:::*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    }
  ]
}
EOF
}
