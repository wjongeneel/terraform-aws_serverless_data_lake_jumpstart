resource "aws_s3_bucket" "taxi-trip-data-raw" {
    bucket = "taxi-trip-data-raw"
    tags = {
        Name = "${var.project_tag}"
    }
}

resource "aws_s3_bucket" "taxi-trip-data-transformed" {
    bucket = "taxi-trip-data-transformed"
    tags = {
        Name = "${var.project_tag}"
    }
}