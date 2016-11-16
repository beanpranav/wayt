class AddNotificationCommentFromUser < ActiveRecord::Migration
  def change
  	add_column :users, :notification_friendship, :boolean, default: true
    add_column :users, :notification_conversation, :boolean, default: true
    add_column :users, :notification_comment, :boolean, default: true
    add_column :participations, :mute, :boolean, default: :false
  end
end
