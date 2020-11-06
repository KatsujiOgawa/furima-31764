class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :password_confirmation, :first_name, :last_name, :first_name_katakana, :last_name_katakana, :birthday_id])
  end
end
