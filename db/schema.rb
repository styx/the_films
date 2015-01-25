# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150125185819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "films", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "second_name"
    t.string   "gapoif",      null: false
    t.string   "url",         null: false
    t.integer  "mins"
    t.integer  "year"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "kind_id"
  end

  add_index "films", ["gapoif"], name: "index_films_on_gapoif", using: :btree
  add_index "films", ["kind_id"], name: "index_films_on_kind_id", using: :btree
  add_index "films", ["name"], name: "index_films_on_name", using: :btree
  add_index "films", ["second_name"], name: "index_films_on_second_name", using: :btree
  add_index "films", ["url"], name: "index_films_on_url", unique: true, using: :btree

  create_table "films_genres", id: false, force: :cascade do |t|
    t.integer "film_id",  null: false
    t.integer "genre_id", null: false
  end

  add_index "films_genres", ["film_id", "genre_id"], name: "index_films_genres_on_film_id_and_genre_id", unique: true, using: :btree
  add_index "films_genres", ["genre_id", "film_id"], name: "index_films_genres_on_genre_id_and_film_id", unique: true, using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "genres", ["name"], name: "index_genres_on_name", unique: true, using: :btree

  create_table "kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kinds", ["name"], name: "index_kinds_on_name", unique: true, using: :btree

  add_foreign_key "films", "kinds"
  add_foreign_key "films_genres", "films"
  add_foreign_key "films_genres", "genres"
end
