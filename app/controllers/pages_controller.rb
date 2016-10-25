# controller for independent pages
class PagesController < ApplicationController
  def home
    if user_signed_in?
      @conversations = current_user.participations
    end
  end

  def test_email
  end
end
