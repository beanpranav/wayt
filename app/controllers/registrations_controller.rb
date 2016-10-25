# Overwrite Device's registartion controller
class RegistrationsController < Devise::RegistrationsController
  def create
    super
    UserMailer.send_signup_email(resource).deliver unless resource.invalid?
  end
end