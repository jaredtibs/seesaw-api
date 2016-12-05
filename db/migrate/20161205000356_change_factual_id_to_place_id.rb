class ChangeFactualIdToPlaceId < ActiveRecord::Migration[5.0]
  def change
    rename_column :locations, :factual_id, :place_id
  end
end
