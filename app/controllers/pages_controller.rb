# controller for independent pages
class PagesController < ApplicationController
  def home
    @conversations = current_user.participations
  end

  def test_email
  end
end
