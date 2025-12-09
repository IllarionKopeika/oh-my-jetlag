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

ActiveRecord::Schema[8.0].define(version: 2025_10_30_041620) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "aircrafts", force: :cascade do |t|
    t.string "name"
    t.string "manufacturer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airlines", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "timezone"
    t.float "latitude"
    t.float "longitude"
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_airports_on_country_id"
  end

  create_table "continents", force: :cascade do |t|
    t.jsonb "name", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_continents_on_name", using: :gin
  end

  create_table "countries", force: :cascade do |t|
    t.jsonb "name", default: {}, null: false
    t.string "code"
    t.string "flag_url"
    t.bigint "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", using: :gin
    t.index ["region_id"], name: "index_countries_on_region_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "number"
    t.datetime "departure_utc"
    t.datetime "departure_local"
    t.datetime "arrival_utc"
    t.datetime "arrival_local"
    t.integer "duration"
    t.float "distance"
    t.integer "status"
    t.integer "type"
    t.bigint "airline_id", null: false
    t.bigint "aircraft_id", null: false
    t.bigint "departure_airport_id", null: false
    t.bigint "arrival_airport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["arrival_airport_id"], name: "index_flights_on_arrival_airport_id"
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
    t.index ["number", "departure_utc", "airline_id", "departure_airport_id", "arrival_airport_id"], name: "idx_on_number_departure_utc_airline_id_departure_ai_07d1add2ea", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.jsonb "name", default: {}, null: false
    t.bigint "continent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["continent_id"], name: "index_regions_on_continent_id"
    t.index ["name"], name: "index_regions_on_name", using: :gin
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "user_flights", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flight_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_user_flights_on_flight_id"
    t.index ["user_id", "flight_id"], name: "index_user_flights_on_user_id_and_flight_id", unique: true
    t.index ["user_id"], name: "index_user_flights_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "airports", "countries"
  add_foreign_key "countries", "regions"
  add_foreign_key "flights", "aircrafts"
  add_foreign_key "flights", "airlines"
  add_foreign_key "flights", "airports", column: "arrival_airport_id"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "regions", "continents"
  add_foreign_key "sessions", "users"
  add_foreign_key "user_flights", "flights"
  add_foreign_key "user_flights", "users"
end
