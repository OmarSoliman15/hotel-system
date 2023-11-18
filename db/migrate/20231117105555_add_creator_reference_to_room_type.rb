class AddCreatorReferenceToRoomType < ActiveRecord::Migration[7.1]
  def change
    add_reference :room_types, :creator, foreign_key: { to_table: :users }
  end
end
