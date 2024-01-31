resource "aws_iam_role" "AWSGlueServiceRole-SDL-Jumpstart" {
    name = "AWSGlueServiceRole-SDL-Jumpstart"
    assume_role_policy = jsonencode({
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Principal":{
            "Service":"glue.amazonaws.com"
         },
         "Action":"sts:AssumeRole"
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
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::[your-bucket]-raw/*",
                "arn:aws:s3:::[your-bucket]-raw",
                "arn:aws:s3:::[your-bucket]-transformed/*",
                "arn:aws:s3:::[your-bucket]-transformed"
            ]
        }
    ]
})
}