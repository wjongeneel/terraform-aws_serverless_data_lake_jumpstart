# This resource is created in lab_1 by the crawler and should thus be imported into the state: terraform import aws_glue_catalog_table.taxi_zone_lookup ...
resource "aws_glue_catalog_table" "taxi_zone_lookup" {
  name          = "taxi_zone_lookup"
  database_name = "nyctaxi-db"
  owner         = "owner"
  table_type    = "EXTERNAL_TABLE"
  parameters = {
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "UPDATED_BY_CRAWLER"               = "nyc-taxi-zone-lookup-csv-crawler"
    "areColumnsQuoted"                 = "false"
    "averageRecordSize"                = "36"
    "classification"                   = "csv"
    "columnsOrdered"                   = "true"
    "compressionType"                  = "none"
    "delimiter"                        = ","
    "objectCount"                      = "1"
    "recordCount"                      = "342"
    "sizeKey"                          = "12322"
    "skip.header.line.count"           = "1"
    "typeOfData"                       = "file"
  }
  storage_descriptor {
    bucket_columns    = []
    compressed        = false
    input_format      = "org.apache.hadoop.mapred.TextInputFormat"
    location          = "s3://taxi-trip-data-raw/nyc-taxi/taxi_zone_lookup/"
    number_of_buckets = -1
    output_format     = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    parameters = {
      "CrawlerSchemaDeserializerVersion" = "1.0"
      "CrawlerSchemaSerializerVersion"   = "1.0"
      "UPDATED_BY_CRAWLER"               = "nyc-taxi-zone-lookup-csv-crawler"
      "areColumnsQuoted"                 = "false"
      "averageRecordSize"                = "36"
      "classification"                   = "csv"
      "columnsOrdered"                   = "true"
      "compressionType"                  = "none"
      "delimiter"                        = ","
      "objectCount"                      = "1"
      "recordCount"                      = "342"
      "sizeKey"                          = "12322"
      "skip.header.line.count"           = "1"
      "typeOfData"                       = "file"
    }
    stored_as_sub_directories = false

    columns {
      name       = "locationid"
      parameters = {}
      type       = "bigint"
    }
    columns {
      name       = "borough"
      parameters = {}
      type       = "string"
    }
    columns {
      name       = "zone"
      parameters = {}
      type       = "string"
    }
    columns {
      name       = "service_zone"
      parameters = {}
      type       = "string"
    }

    ser_de_info {
      parameters = {
        "escapeChar"    = "\\"
        "quoteChar"     = "\""
        "separatorChar" = ","
      }
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
    }
  }
}

resource "aws_glue_job" "transform_nyc_taxi_trip_data" {
  name              = "Transform NYC Taxi Trip Data"
  number_of_workers = 10
  worker_type       = "G.1X"
  role_arn          = data.aws_iam_role.AWSGlueServiceRole-SDL-Jumpstart.arn
  command {
    script_location = "s3://${aws_s3_bucket.aws-glue-assets-563970825816-eu-west-1.bucket}/scripts/Transform NYC Taxi Trip Data.py"
    python_version  = "3"
  }
  default_arguments = {
    "--TempDir"                          = "s3://aws-glue-assets-563970825816-eu-west-1/temporary/"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-job-insights"              = "false"
    "--enable-metrics"                   = "true"
    "--enable-observability-metrics"     = "true"
    "--enable-spark-ui"                  = "true"
    "--job-bookmark-option"              = "job-bookmark-disable"
    "--job-language"                     = "python"
    "--spark-event-logs-path"            = "s3://aws-glue-assets-563970825816-eu-west-1/sparkHistoryLogs/"
  }
}

resource "aws_glue_crawler" "nyc-yellow-tripdata-parquet-crawler" {
  name          = "nyc-yellow-tripdata-parquet-crawler"
  database_name = "nyctaxi-db"
  role          = data.aws_iam_role.AWSGlueServiceRole-SDL-Jumpstart.arn
  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }
  s3_target {
    path = "s3://${data.aws_s3_bucket.taxi-trip-data-transformed.bucket}/nyc-taxi/yellow-tripdata"
  }
}