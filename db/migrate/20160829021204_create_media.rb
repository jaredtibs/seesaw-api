class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.belongs_to :user, index: true
      t.belongs_to :post, index: true
      t.integer    :kind, default: 1
      t.string     :caption

      t.timestamps null: false
    end
  end
end
