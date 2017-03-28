class AddCachedColumnsToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :cached_votes_count, :integer, default: 0
    add_column :locations, :cached_posts_count, :integer, default: 0
    add_column :locations, :cached_photos_count, :integer, default: 0
  end
end
