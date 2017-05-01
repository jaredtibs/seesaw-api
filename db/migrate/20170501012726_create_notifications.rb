class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text :body
      t.boolean :checked
      t.integer :kind
    end
  end
end
