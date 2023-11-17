class CreateRoomTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :room_types do |t|
      t.string :name
      t.text :description
      t.integer :max_adult
      t.integer :max_kids, default: 0
      t.decimal :price_per_night, precision: 7, scale: 2
      t.integer :available_rooms

      t.timestamps
    end
  end
end
