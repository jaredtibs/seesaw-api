class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :description
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :locations, [:latitude, :longitude], unique: true
  end
end
