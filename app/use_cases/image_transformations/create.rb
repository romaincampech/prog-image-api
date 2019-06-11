module ImageTransformations
  class Create
    include SolidUseCase

    steps :find_original_image,
          :create_image_transformation

    def find_original_image(params)
      params[:original_image] = Image.find_by(id: params[:id])
      return fail :not_found, error: 'NOT_FOUND' unless params[:original_image].present?

      continue params
    end

    def create_image_transformation(params)
      image = MiniMagick::Image.open(params[:original_image].file.url)
      params[:specs].each do |spec, value|
        image.send(spec, value)
      end

      params[:image_transformation] = ImageTransformation.create!(
                                        original: params[:original_image],
                                        specs: params[:specs],
                                        file: File.open(image.path),
                                      )

      continue params[:image_transformation]
    end
  end
end
