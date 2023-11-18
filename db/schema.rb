# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_18_024234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservation_room_types", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "room_type_id", null: false
    t.decimal "price_per_night", precision: 7, scale: 2
    t.integer "number_of_rooms", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservation_room_types_on_reservation_id"
    t.index ["room_type_id"], name: "index_reservation_room_types_on_room_type_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "status", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.integer "number_of_adults"
    t.integer "number_of_kids"
    t.integer "total_price"
    t.datetime "cancelled_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_reservations_on_status"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "max_adult"
    t.integer "max_kids", default: 0
    t.decimal "price_per_night", precision: 7, scale: 2
    t.integer "available_rooms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_room_types_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "role"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reservation_room_types", "reservations"
  add_foreign_key "reservation_room_types", "room_types"
  add_foreign_key "reservations", "users"
  add_foreign_key "room_types", "users", column: "creator_id"
end
