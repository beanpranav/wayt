class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :participation_id
      t.integer :conversation_id
      t.text :content

      t.timestamps
    end
  end
end
