# rubocop:disable Metrics/LineLength
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  ensure_security_headers hsts: { max_age: 631_138_519, include_subdomain: true },
                          x_frame_options: { value: 'SAMEORIGIN' },
                          x_content_type_options: { value: 'nosniff' },
                          x_xss_protection: { value: 1, mode: 'block' },
                          csp: false

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :authenticate_admin, :admin_email

  protected

  # for allowing :name as a strong parameter while signup and account update.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def authenticate_admin
    if current_user.email == 'bean.pranav@gmail.com'
      true
    else
      redirect_to root_path, notice: "You don't have permission to view this page."
    end
  end

  def admin_email
    'pranav@whatareyourthoughts.org'
  end
end
