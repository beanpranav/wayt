# Overwrite Device's registartion controller
class RegistrationsController < Devise::RegistrationsController
  def create
    super
    UserNotifier.send_signup_email(resource).deliver unless resource.invalid?
  end
end
