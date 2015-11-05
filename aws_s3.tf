#####################################
# S3
#####################################
resource "aws_s3_bucket" "demo-uploads" {
  bucket = "demo-uploads"
  acl = "private"
  policy = "${file("demo_uploads_bucket_policy.json")}"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags {
    Name = "demo-uploads"
  }
}
resource "aws_s3_bucket" "demo-elb-logs" {
  bucket = "demo-elb-logs"
  acl = "private"
  tags {
    Name = "demo-elb-logs"
  }
}
