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

ActiveRecord::Schema.define(version: 20190305033140) do

  create_table "properties", force: :cascade do |t|
    t.integer "user_id"
    t.string "owner_name"
    t.string "property_type"
    t.string "property_status"
    t.string "bed_rooms"
    t.string "area"
    t.string "price"
    t.string "street_address"
    t.string "locality"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["area"], name: "index_properties_on_area"
    t.index ["bed_rooms"], name: "index_properties_on_bed_rooms"
    t.index ["city"], name: "index_properties_on_city"
    t.index ["created_at"], name: "index_properties_on_created_at"
    t.index ["locality"], name: "index_properties_on_locality"
    t.index ["price"], name: "index_properties_on_price"
    t.index ["property_status"], name: "index_properties_on_property_status"
    t.index ["property_type"], name: "index_properties_on_property_type"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
  end

end
