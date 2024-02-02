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