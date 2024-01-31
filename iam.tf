resource "aws_iam_role" "AWSGlueServiceRole-SDL-Jumpstart" {
  name = "AWSGlueServiceRole-SDL-Jumpstart"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "glue.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "${var.project_tag}"
  }
}

resource "aws_iam_role_policy" "glue-trust-policy" {
  name = "glue-trust-policy"
  role = aws_iam_role.AWSGlueServiceRole-SDL-Jumpstart.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.taxi-trip-data-raw.bucket}/*",
          "arn:aws:s3:::${aws_s3_bucket.taxi-trip-data-raw.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.taxi-trip-data-transformed.bucket}/*",
          "arn:aws:s3:::${aws_s3_bucket.taxi-trip-data-transformed.bucket}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream"
        ],
        "Resource" : [
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:log-stream:${aws_glue_crawler.nyc-taxi-yellow-trips-csv-crawler.name}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:GetDatabase",
          "glue:GetTable"
        ],
        "Resource" : [
          "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:catalog",
          "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:database/${aws_glue_catalog_database.nyctaxi-db.name}",
          "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:table/${aws_glue_catalog_database.nyctaxi-db.name}/*"
        ]
      }
    ]
  })
}