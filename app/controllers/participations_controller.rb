# rubocop:disable Metrics/LineLength
class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :mark_as_unread, :mark_as_read, :unmute, :mute]

  def show
    if @participation.unread?
      @participation.update_attribute(:read, true)
    else
      @participation.touch
    end
    redirect_to conversation_path(@participation.conversation)
  end

  def mark_as_unread
    @participation.update_attribute(:read, false)
    redirect_to root_path, notice: 'Marked as unread.'
  end

  def mark_as_read
    @participation.update_attribute(:read, true)
    redirect_to root_path, notice: 'Marked as read.'
  end

  def unmute
    @participation.update_attribute(:mute, false)
    redirect_to participation_path(@participation), notice: 'Discussion unmuted.'
  end

  def mute
    @participation.update_attribute(:mute, true)
    redirect_to participation_path(@participation), notice: 'Discussion muted.'
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end
end
