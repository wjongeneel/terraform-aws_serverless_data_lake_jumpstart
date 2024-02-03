data "aws_caller_identity" "current" {}

data "aws_iam_role" "AWSGlueServiceRole-SDL-Jumpstart" {
  name = "AWSGlueServiceRole-SDL-Jumpstart"
}

data "aws_s3_bucket" "taxi-trip-data-transformed" {
  bucket = "taxi-trip-data-transformed"
}
