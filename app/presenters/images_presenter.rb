class ImagesPresenter < BasePresenter
  def as_json(*)
    {
      image: image,
      original_id: original_id,
      specs: specs,
      transformations: transformations,
    }
  end

  private

  def image
    {
      id: object.id,
      filename: object.file.original_filename,
      url: object.file.url,
      size_bytes: object.file.size,
      extension: object.file.extension,
      mime_type: object.file.mime_type,
    }
  end

  def original_id
    p object.is_an_image_transformation?
    return nil unless object.is_an_image_transformation?

    object.original.id
  end

  def specs
    return nil unless object.is_an_image_transformation?

    object.specs
  end

  def transformations
    return nil unless object.is_an_image?

    object.transformations.map do |transformation|
      self.class.new(transformation)
    end
  end
end
