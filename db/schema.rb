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

ActiveRecord::Schema[7.0].define(version: 2024_02_06_164045) do
  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.text "address"
    t.string "credit_card_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "attendees", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.text "address"
    t.string "credit_card_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_attendees_on_reset_password_token", unique: true
  end

  create_table "event_tickets", force: :cascade do |t|
    t.integer "attendee_id"
    t.integer "admin_id"
    t.integer "event_id", null: false
    t.integer "room_id", null: false
    t.string "confirmation_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_event_tickets_on_admin_id"
    t.index ["attendee_id"], name: "index_event_tickets_on_attendee_id"
    t.index ["event_id"], name: "index_event_tickets_on_event_id"
    t.index ["room_id"], name: "index_event_tickets_on_room_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "room_id", null: false
    t.string "category"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.decimal "ticket_price"
    t.integer "seats_left"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_events_on_room_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "attendee_id"
    t.integer "event_id", null: false
    t.integer "admin_id"
    t.integer "rating"
    t.text "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_reviews_on_admin_id"
    t.index ["attendee_id"], name: "index_reviews_on_attendee_id"
    t.index ["event_id"], name: "index_reviews_on_event_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.text "address"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_tickets", "admins"
  add_foreign_key "event_tickets", "attendees"
  add_foreign_key "event_tickets", "events"
  add_foreign_key "event_tickets", "rooms"
  add_foreign_key "events", "rooms"
  add_foreign_key "reviews", "admins"
  add_foreign_key "reviews", "attendees"
  add_foreign_key "reviews", "events"
end
