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

ActiveRecord::Schema.define(version: 20150228015009) do

  create_table "admin_thing", force: :cascade do |t|
    t.integer "admin_id"
    t.string  "value"
    t.integer "thing_id"
  end

  create_table "admin_things", force: :cascade do |t|
    t.integer "admin_id"
    t.string  "value"
    t.integer "thing_id"
  end

  create_table "admin_trait_modifiers", force: :cascade do |t|
    t.integer "admin_trait_id"
    t.string  "modifier"
  end

  create_table "admin_traits", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blah_id"
    t.string  "value"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
  end

  create_table "guest_thing", force: :cascade do |t|
    t.integer "guest_id"
    t.string  "value"
    t.integer "thing_id"
  end

  create_table "guest_things", force: :cascade do |t|
    t.integer "guest_id"
    t.string  "value"
    t.integer "thing_id"
  end

  create_table "guest_trait_modifiers", force: :cascade do |t|
    t.integer "guest_trait_id"
    t.string  "modifier"
  end

  create_table "guest_traits", force: :cascade do |t|
    t.integer "guest_id"
    t.integer "trait_id"
    t.string  "value"
  end

  create_table "guests", force: :cascade do |t|
    t.string "name"
  end

  create_table "properties", force: :cascade do |t|
    t.integer "user_id"
    t.string  "user_type"
    t.string  "value"
  end

  create_table "standalones", force: :cascade do |t|
    t.string "value"
  end

  create_table "thing", force: :cascade do |t|
    t.string "value"
  end

  create_table "things", force: :cascade do |t|
    t.string "value"
  end

  create_table "traits", force: :cascade do |t|
    t.string "name"
  end

end
