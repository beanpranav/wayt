# controller for independent pages
class PagesController < ApplicationController
  def home
  end

  def test_email
    # Deliver the signup email
    UserNotifier.send_signup_email(current_user).deliver
    redirect_to(root_path, notice: 'User created')
  end
end
