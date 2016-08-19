class AddLastHereToUserLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :user_locations, :last_here, :datetime
    add_index :user_locations, [:user_id, :location_id], unique: true
  end
end
