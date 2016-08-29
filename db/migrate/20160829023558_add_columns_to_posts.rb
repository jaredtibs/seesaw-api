class AddColumnsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :reported_by, :integer, array: true, default: []
    add_column :posts, :upvote_count, :integer, default: 0
  end
end
