resource "aws_s3_bucket" "aws-athena-query-results-eu-west-1-563970825816" {
  bucket = "aws-athena-query-results-eu-west-1-563970825816"
  tags = {
    Name = "${var.project_tag}"
  }
}