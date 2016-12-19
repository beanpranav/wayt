# Overwrite Device's registartion controller
# rubocop:disable Metrics/LineLength
class RegistrationsController < Devise::RegistrationsController
  def create
    super
    unless resource.invalid?
      UserNotifier.welcome_email(resource).deliver
      UserNotifier.admin_new_user_email(resource).deliver
    end
  end

  def toggle_friendship_notification
    current_user.toggle!(:notification_friendship)
    redirect_to notification_settings_path, notice: 'Notification settings updated.'
  end

  def toggle_conversation_notification
    current_user.toggle!(:notification_conversation)
    redirect_to notification_settings_path, notice: 'Notification settings updated.'
  end

  def toggle_reply_notification
    current_user.toggle!(:notification_comment)
    redirect_to notification_settings_path, notice: 'Notification settings updated.'
  end

  protected

  def after_sign_up_path_for(_resource)
    root_path
  end
end
