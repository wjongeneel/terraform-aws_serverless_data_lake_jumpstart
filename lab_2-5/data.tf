data "aws_caller_identity" "current" {}

data "aws_iam_role" "AWSGlueServiceRole-SDL-Jumpstart" {
  name = "AWSGlueServiceRole-SDL-Jumpstart"
}

