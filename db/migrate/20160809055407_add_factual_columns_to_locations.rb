class AddFactualColumnsToLocations < ActiveRecord::Migration[5.0]
  def change
    remove_column :locations, :state
    remove_column :locations, :street

    add_column :locations, :region, :string
    add_column :locations, :address, :string
    add_column :locations, :factual_id, :string
    add_column :locations, :categories, :string, array: true, default: []
  end
end
