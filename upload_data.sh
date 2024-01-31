#!/bin/bash

# Citation
# New York City Taxi and Limousine Commission (TLC) Trip Record Data was accessed on 31-01-2024 from https://registry.opendata.aws/nyc-tlc-trip-records-pds.

# Upload the yellow taxi trip data dataset
aws s3 cp s3://nyc-tlc/csv_backup/ s3://taxi-trip-data-raw/nyc-taxi/yellow-tripdata/ --exclude "*" --include "yellow_tripdata_2020*" --recursive 

# Upload the taxi zone lookup table
aws s3 cp "s3://nyc-tlc/misc/taxi _zone_lookup.csv" s3://taxi-trip-data-transformed/nyc-taxi/taxi_zone_lookup/taxi_zone_lookup.csv
