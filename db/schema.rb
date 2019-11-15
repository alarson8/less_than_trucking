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

ActiveRecord::Schema.define(version: 2019_11_15_033149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "random_fulfillments", force: :cascade do |t|
    t.boolean "best_capacity", default: false, null: false
    t.boolean "best_deliveries", default: false, null: false
    t.jsonb "log", default: "{}", null: false
    t.integer "deliveries", null: false
    t.integer "remaining_capacity", null: false
    t.float "average_equal_distribution"
    t.integer "seconds_since_epoch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
