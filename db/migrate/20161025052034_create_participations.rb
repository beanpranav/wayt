class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :read, default: false
      t.boolean :important, default: false
      t.integer :others_count, default: 0

      t.timestamps
    end
    add_index :participations, :user_id
    add_index :participations, :conversation_id
    add_index :participations, :important
  end
end
