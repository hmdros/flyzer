# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_04_203450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "iata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer "available_seats"
    t.bigint "company_id"
    t.bigint "origin_id"
    t.bigint "destination_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "sku"
    t.float "convenience"
    t.index ["arrival_time"], name: "index_flights_on_arrival_time"
    t.index ["company_id"], name: "index_flights_on_company_id"
    t.index ["departure_time"], name: "index_flights_on_departure_time"
    t.index ["destination_id"], name: "index_flights_on_destination_id"
    t.index ["origin_id"], name: "index_flights_on_origin_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.string "flight_sku"
    t.integer "amount_cents", default: 0, null: false
    t.jsonb "payment"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seat"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "lat"
    t.string "lon"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stops", force: :cascade do |t|
    t.integer "duration"
    t.bigint "place_id"
    t.bigint "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_stops_on_flight_id"
    t.index ["place_id"], name: "index_stops_on_place_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "number"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.bigint "origin_id"
    t.bigint "destination_id"
    t.bigint "company_id"
    t.bigint "user_id"
    t.bigint "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_tickets_on_company_id"
    t.index ["destination_id"], name: "index_tickets_on_destination_id"
    t.index ["flight_id"], name: "index_tickets_on_flight_id"
    t.index ["origin_id"], name: "index_tickets_on_origin_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "refresh_token"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flights", "companies"
  add_foreign_key "flights", "places", column: "destination_id"
  add_foreign_key "flights", "places", column: "origin_id"
  add_foreign_key "orders", "users"
  add_foreign_key "stops", "flights"
  add_foreign_key "stops", "places"
  add_foreign_key "tickets", "companies"
  add_foreign_key "tickets", "flights"
  add_foreign_key "tickets", "places", column: "destination_id"
  add_foreign_key "tickets", "places", column: "origin_id"
  add_foreign_key "tickets", "users"
end
