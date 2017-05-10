class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :initiator_id, index: true, foreign_key: true
      t.integer :receiver_id, index: true, foreign_key: true
      t.text :body
      t.boolean :checked, default: false
      t.integer :kind

      t.timestamps null: false
    end
  end
end
