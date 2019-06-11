module Images
  class Show
    include SolidUseCase

    steps :find_image

    def find_image(params)
      params[:image] = Image.find_by(id: params[:id])
      params[:image] ||= ImageTransformation.find_by(id: params[:id])
      return continue params[:image] if params[:image].present?

      fail :not_found, error: 'NOT_FOUND'
    end
  end
end
