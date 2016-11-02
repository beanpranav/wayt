# controller for independent pages
class PagesController < ApplicationController
  def home
    if user_signed_in?
      @participations = current_user.participations_ordered_by_comments
      # participations.includes(:comments).order("comments.created_at desc")
    end
  end

  def contacts
  end
end
