class CreateReservationRoomTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :reservation_room_types do |t|
      t.belongs_to :reservation, null: false, foreign_key: true
      t.belongs_to :room_type, null: false, foreign_key: true
      t.decimal :price_per_night, precision: 7, scale: 2
      t.integer :number_of_rooms, default: 1

      t.timestamps
    end
  end
end
