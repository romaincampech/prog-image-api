class ImageTransformationsController < ApplicationController
  def create
    ImageTransformations::Create.run(image_transformation_params).match do
      success do |image|
        render_success(ImagesPresenter.new(image))
      end

      failure :not_found do |error|
        render_error(error, :not_found)
      end
    end
  end

  private

  def image_transformation_params
    params.permit(:id, specs: [:format])
  end
end
