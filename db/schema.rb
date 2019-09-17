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

ActiveRecord::Schema.define(version: 2019_09_10_141234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "zip"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "city"
    t.string "uf"
    t.bigint "user_id"
    t.bigint "garage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garage_id"], name: "index_addresses_on_garage_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "message"
    t.bigint "from_user_id_id"
    t.bigint "to_user_id_id"
    t.float "rating"
    t.bigint "garage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id_id"], name: "index_comments_on_from_user_id_id"
    t.index ["garage_id"], name: "index_comments_on_garage_id"
    t.index ["to_user_id_id"], name: "index_comments_on_to_user_id_id"
  end

  create_table "garages", force: :cascade do |t|
    t.string "description"
    t.integer "parking_spaces"
    t.float "price"
    t.string "photo1"
    t.string "photo2"
    t.string "photo3"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_garages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "document_type", default: "cpf", null: false
    t.string "document_number"
    t.string "password_digest"
    t.string "role", default: "user", null: false
    t.boolean "isActive", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "model"
    t.string "chassi"
    t.string "license_plate"
    t.string "year"
    t.string "driver_license"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

end
