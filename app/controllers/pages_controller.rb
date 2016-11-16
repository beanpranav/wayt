# controller for independent pages
class PagesController < ApplicationController
  def home
    if user_signed_in?
      @participations = current_user.participations_ordered_by_comments
    end
  end

  def notification_settings
  end
end
