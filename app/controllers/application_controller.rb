class ApplicationController < Jets::Controller::Base

  protected

  def render_success(body, status = :ok)
    render json: body,
           status: status
  end

  def render_error(errors, status = :unprocessable_entity)
    render json: errors.marshal_dump,
           status: status
  end
end
