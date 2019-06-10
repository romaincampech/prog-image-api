require 'shrine'
require 'shrine/storage/s3'

s3_options = {
  bucket: ENV['S3_BUCKET'],
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: 'eu-west-2',
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(**s3_options),
  store: Shrine::Storage::S3.new(**s3_options),
}
