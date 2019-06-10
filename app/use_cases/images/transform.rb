module Images
  class Transform
    include SolidUseCase

    steps :find_original_image,
          :find_image_transformation,
          :create_image_transformation

    def find_original_image(params)
      params[:original_image] = Image.find(params[:id])
      return fail :image_not_found, error: 'IMAGE_NOT_FOUND' unless params[:original_image]

      continue params
    end

    def find_image_transformation(params)
      params[:image_transformation] = params[:original_image].image_transformations.find_by(specs: params[:specs])
      return continue params[:image_transformation] if params[:image_transformation]

      continue params
    end

    def create_image_transformation(params)
      image = MiniMagick::Image.open(params[:original_image].url)
      specs.each do |spec, value|
        image.send(spec, value)
      end

      parmas[:image_transformation] = ImageTransformation.create!(
                                        original_image: params[:original_image],
                                        specs: params[:specs],
                                        file: image,
                                      )

      continue params[:image_transformation]
    end
  end
end
