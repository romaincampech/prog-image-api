class ImagesController < ApplicationController
  def upload
    Images::Upload.run(upload_params).match do
      success do |image|
        render json: {
          id: image.id,
        }
      end
    end
  end

  private

  def upload_params
    params.permit(:file)
  end
end
