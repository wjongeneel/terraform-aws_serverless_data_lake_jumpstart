resource "aws_s3_bucket" "aws-athena-query-results-eu-west-1-563970825816" {
  bucket        = "aws-athena-query-results-eu-west-1-563970825816"
  force_destroy = true
  tags = {
    Name = "${var.project_tag}"
  }
}

resource "aws_s3_bucket" "aws-glue-assets-563970825816-eu-west-1" {
  bucket        = "aws-glue-assets-563970825816-eu-west-1"
  force_destroy = true
  tags = {
    Name = "${var.project_tag}"
  }
}
