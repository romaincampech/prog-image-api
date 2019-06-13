module Images
  class Create
    include SolidUseCase

    steps :validate_params,
          :create_image

    def validate_params(params)
      return fail :unprocessable_entity, error: 'UNPROCESSABLE_ENTITY' unless valid_params?(params)

      continue params
    end

    def create_image(params)
      image = Image.new
      if remote_url?(params)
        image.file_remote_url = params[:file]
      else
        image.file = params[:file]
      end
      image.save!

      continue image
    rescue
      fail :unprocessable_entity, error: 'UNPROCESSABLE_ENTITY'
    end

    private

    def valid_params?(params)
      remote_url?(params) || file?(params)
    end

    def remote_url?(params)
      return false unless params[:file].is_a?(String)

      uri = URI.parse(params[:file])
      %w( http https ).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end

    def file?(params)
      params[:file].is_a?(File) ||
      params[:file].is_a?(ActionDispatch::Http::UploadedFile)
    end
  end
end
