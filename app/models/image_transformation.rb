class ImageTransformation < ApplicationRecord
  belongs_to :original, foreign_key: 'image_id', class_name: 'Image'
end
