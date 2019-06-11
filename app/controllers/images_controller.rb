class ImagesController < ApplicationController
  def show
    Images::Show.run(show_params).match do
      success do |image|
        render_success(ImagesPresenter.new(image))
      end

      failure :not_found do |error|
        render_error(error, :not_found)
      end
    end
  end

  def upload
    Images::Upload.run(upload_params).match do
      success do |image|
        render json: {
          id: image.id,
        }
      end
    end
  end

  def transform
    Images::Transform.run(transform_params).match do
      success do |image|
        render json: {
          id: image.id,
        }
      end
    end
  end

  private

  def show_params
    params.permit(:id)
  end

  def upload_params
    params.permit(:file)
  end

  def transform_params
    params.permit(:id, specs: [])
  end
end
