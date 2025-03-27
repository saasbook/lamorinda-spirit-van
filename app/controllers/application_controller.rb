# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_role, if: :user_signed_in?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    # Remove :role so new users don't set it on sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [])
  end

  # This filter checks if a logged-in user has a role
  def check_user_role
    if current_user.role.blank?
      sign_out(current_user)
      redirect_to new_user_session_path, alert: "Your account is awaiting role assignment. Please contact an admin."
    end
  end
end
