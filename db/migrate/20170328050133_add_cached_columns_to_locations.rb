class AddCachedColumnsToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :cached_vote_count, :integer, default: 0
    add_column :locations, :cached_post_count, :integer, default: 0
    add_column :locations, :cached_photo_count, :integer, default: 0
  end
end
