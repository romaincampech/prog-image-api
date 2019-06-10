module Images
  class Upload
    include SolidUseCase

    steps :create_image

    def create_image(params)
      continue Image.create!(file: params[:file])
    end
  end
end
