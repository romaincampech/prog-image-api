class ImagesPresenter < BasePresenter
  def as_json(*)
    {
      image: {
        id: object.id,
        filename: object.file.original_filename,
        url: object.file.url,
        size_bytes: object.file.size,
        extension: object.file.extension,
        mime_type: object.file.mime_type,
      },
    }
  end
end
