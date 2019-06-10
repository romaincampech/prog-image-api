class Image < ApplicationRecord
  has_many :transformations, foreign_key: 'image_id', class_name: 'ImageTransformation'

  include ImageUploader::Attachment.new(:file)
end
