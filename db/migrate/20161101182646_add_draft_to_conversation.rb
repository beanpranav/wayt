class AddDraftToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :draft, :boolean, default: true
    add_column :conversations, :recipient_ids, :string, array: true, default: []
    remove_column :conversations, :recipient
    remove_column :conversations, :friendship_id
    remove_column :conversations, :source_author
    remove_column :conversations, :source_content
  end
end
