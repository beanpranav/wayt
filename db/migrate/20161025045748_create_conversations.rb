class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :friendship_id, default: 0
      t.string :subject
      t.string :source_author
      t.string :source_link
      t.text :source_content
      t.text :first_comment
      t.string :slug

      t.timestamps
    end
    add_index :conversations, :user_id
    add_index :conversations, :friendship_id
  end
end
