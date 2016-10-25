class AddFriendshipIdToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :friendship_id, :integer, default: 0
    add_index :conversations, :friendship_id
  end
end
