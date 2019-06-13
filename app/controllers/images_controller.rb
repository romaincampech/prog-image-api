class ImagesController < ApplicationController
  def show
    Images::Show.run(show_params).match do
      success do |image|
        render_success(ImagePresenter.new(image))
      end

      failure :not_found do |error|
        render_error(error, :not_found)
      end
    end
  end

  def create
    Images::Create.run(create_params).match do
      success do |image|
        render_success(ImagePresenter.new(image))
      end

      failure :unprocessable_entity do |error|
        render_error(error)
      end
    end
  end

  private

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:file)
  end
end
