class CreateUserLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_locations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :location, index: true

      t.timestamps null: false
    end
  end
end
