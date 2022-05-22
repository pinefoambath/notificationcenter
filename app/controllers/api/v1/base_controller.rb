class Api::V1::BaseController < ActionController::API
  
  rescue_from StandardError,                with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_authorisation_error 
    render json: { error: "You are not authorized to perform this action." }, status: :unauthorized
  end 
end