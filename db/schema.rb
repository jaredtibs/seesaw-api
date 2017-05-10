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

ActiveRecord::Schema.define(version: 20170501012726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "postal_code"
    t.string   "description"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image"
    t.string   "region"
    t.string   "address"
    t.string   "place_id"
    t.string   "categories",         default: [],              array: true
    t.integer  "cached_vote_count",  default: 0
    t.integer  "cached_post_count",  default: 0
    t.integer  "cached_photo_count", default: 0
    t.index ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude", unique: true, using: :btree
  end

  create_table "media", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "kind",       default: 1
    t.string   "caption"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["post_id"], name: "index_media_on_post_id", using: :btree
    t.index ["user_id"], name: "index_media_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "initiator_id"
    t.integer  "receiver_id"
    t.text     "body"
    t.boolean  "checked",      default: false
    t.integer  "kind"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["initiator_id"], name: "index_notifications_on_initiator_id", using: :btree
    t.index ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "hidden",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reported_by",  default: [],    array: true
    t.integer  "upvote_count", default: 0
    t.integer  "visibility",   default: 1
    t.string   "media"
  end

  create_table "user_locations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "last_here"
    t.index ["location_id"], name: "index_user_locations_on_location_id", using: :btree
    t.index ["user_id", "location_id"], name: "index_user_locations_on_user_id_and_location_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_locations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "avatar"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

end
