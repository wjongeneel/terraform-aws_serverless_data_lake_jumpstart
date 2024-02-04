resource "aws_s3_bucket" "taxi-trip-data-raw" {
  bucket = "taxi-trip-data-raw"
  force_destroy = true
  tags = {
    Name = "${var.project_tag}"
  }
}

resource "aws_s3_bucket" "taxi-trip-data-transformed" {
  bucket = "taxi-trip-data-transformed"
  force_destroy = true
  tags = {
    Name = "${var.project_tag}"
  }
}