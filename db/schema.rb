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

ActiveRecord::Schema.define(version: 20180819141506) do

  create_table "locations", force: :cascade do |t|
    t.integer "zipcode"
    t.integer "score", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assault_count", default: 0
    t.integer "shooting_count", default: 0
    t.integer "rape_count", default: 0
    t.integer "theft_count", default: 0
    t.integer "burglary_count", default: 0
    t.integer "robbery_count", default: 0
    t.integer "population"
    t.text "polygon"
  end

end
