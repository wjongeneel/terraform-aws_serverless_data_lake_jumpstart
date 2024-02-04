resource "aws_athena_workgroup" "athena_workgroup_nyctaxi" {
  name = "athena_workgroup_nyctaxi"
  force_destroy = true
  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.aws-athena-query-results-eu-west-1-563970825816.bucket}/output/"
    }
  }
  tags = {
    Name = "${var.project_tag}"
  }
}