class ImageUploader < Shrine
  plugin :activerecord
  plugin :delete_promoted
  plugin :determine_mime_type
  plugin :logging, format: :json
  plugin :remote_url, max_size: 20*1024*1024
  plugin :remove_invalid
  plugin :store_dimensions
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/png image/gif], message: 'must be JPEG, PNG or GIF'
    validate_extension_inclusion %w[jpg jpeg png gif], message: 'must be JPEG, PNG or GIF'
  end
end
