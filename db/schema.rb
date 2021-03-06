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

ActiveRecord::Schema.define(version: 2019_04_16_083607) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "property_id"
    t.text "comment"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false
    t.datetime "approved_at"
    t.integer "approved_by_id"
    t.index ["approved_by_id"], name: "index_comments_on_approved_by_id"
    t.index ["property_id", "created_at"], name: "index_comments_on_property_id_and_created_at"
    t.index ["property_id"], name: "index_comments_on_property_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_identities_on_uid_and_provider", unique: true
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.integer "user_id"
    t.string "owner_name"
    t.string "property_type"
    t.string "property_status"
    t.string "bed_rooms"
    t.integer "area"
    t.integer "price"
    t.string "street_address"
    t.string "locality"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false
    t.datetime "approved_at"
    t.integer "approved_by_id"
    t.boolean "sold", default: false
    t.datetime "sold_at"
    t.integer "buyer_id"
    t.index ["approved_by_id"], name: "index_properties_on_approved_by_id"
    t.index ["area"], name: "index_properties_on_area"
    t.index ["bed_rooms"], name: "index_properties_on_bed_rooms"
    t.index ["buyer_id"], name: "index_properties_on_buyer_id"
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
    t.boolean "seller", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "visitors", force: :cascade do |t|
    t.string "remote_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["remote_ip"], name: "index_visitors_on_remote_ip", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_wishlists_on_property_id"
    t.index ["user_id", "property_id"], name: "index_wishlists_on_user_id_and_property_id", unique: true
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

end
