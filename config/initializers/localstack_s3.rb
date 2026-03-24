
::S3_CREDENTIALS ||= {
  access_key_id: "1", # aws user content_wasya_co_s3
  secret_access_key: "2",
  bucket: "app-main",
  region: 'us-east-1',

  access_key_id_ses: "3", # iam user email_wasya_co_ses , only email receiving
  secret_access_key_ses: "4",
  bucket_ses: 'app-ses',
  region_ses: 'us-east-1',
}