class AddRecipientToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :recipient, :integer, array: true, default: []
    remove_column :conversations, :first_comment
  end
end
