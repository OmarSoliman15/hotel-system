class AddCreatorReferenceToRoomType < ActiveRecord::Migration[7.1]
  def change
    add_reference :room_types, :creator, null: false, foreign_key: { to_table: :users }
  end
end
