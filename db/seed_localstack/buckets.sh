#!/bin/bash

echo "+++ localstack seed: creating buckets..."

set -e

## Use AWS CLI to create buckets
# aws --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket-1
# aws --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket-2

awslocal s3 mb s3://app-main
awslocal s3 mb s3://app-ses
awslocal s3 ls

