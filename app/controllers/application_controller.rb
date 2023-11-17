class ApplicationController < ActionController::API
  respond_to :json
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email])
  end

  def error_response(errors, status = :unprocessable_entity)
    render json: { errors: errors }, status: status
  end
end
