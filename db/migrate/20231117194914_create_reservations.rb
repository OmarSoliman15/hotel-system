class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: :reserved
      t.date :start_date, null: false
      t.date :end_date
      t.integer :number_of_adults
      t.integer :number_of_kids
      t.integer :total_price
      t.timestamp :cancelled_at

      t.timestamps
    end

    add_index :reservations, :status
  end
end
