resource "aws_glue_catalog_database" "nyctaxi-db" {
  name = "nyctaxi-db"
}

resource "aws_glue_crawler" "nyc-taxi-yellow-trips-csv-crawler" {
  name          = "nyc-taxi-yellow-trips-csv-crawler"
  database_name = aws_glue_catalog_database.nyctaxi-db.name
  role          = aws_iam_role.AWSGlueServiceRole-SDL-Jumpstart.arn
  table_prefix  = "raw_"
  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }
  s3_target {
    path = "s3://${aws_s3_bucket.taxi-trip-data-raw.bucket}/nyc-taxi/yellow-tripdata"
  }
}

resource "aws_glue_crawler" "nyc-taxi-zone-lookup-csv-crawler" {
  name          = "nyc-taxi-zone-lookup-csv-crawler"
  database_name = aws_glue_catalog_database.nyctaxi-db.name
  role          = aws_iam_role.AWSGlueServiceRole-SDL-Jumpstart.arn
  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }
  s3_target {
    path = "s3://${aws_s3_bucket.taxi-trip-data-raw.bucket}/nyc-taxi/taxi_zone_lookup"
  }
}

