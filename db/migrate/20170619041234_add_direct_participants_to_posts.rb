class AddDirectParticipantsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :direct_participants, :integer, array: true, default: []
  end
end
