class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text    :body
      t.integer :user_id
      t.integer :location_id
      t.boolean :hidden, default: false
    end
  end
end
