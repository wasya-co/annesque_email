
::S3_CREDENTIALS ||= {
  access_key_id: "",
  secret_access_key: "",
  bucket: "app-main",
  region: 'us-east-1',
}

::SES_S3_CREDENTIALS ||= {
  endpoint: "http://localhost:4566/",
  force_path_style: true,
}
::SES_S3_BUCKET ||= "app-ses"
