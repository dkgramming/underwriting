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

ActiveRecord::Schema.define(version: 20180316034645) do

  create_table "properties", force: :cascade do |t|
    t.string "address", null: false
    t.integer "marketing_expense", default: 0
    t.integer "tax_expense", default: 0
    t.integer "insurance_expense", default: 0
    t.integer "repair_expense", default: 0
    t.integer "admin_expense", default: 0
    t.integer "payroll_expense", default: 0
    t.integer "utility_expense", default: 0
    t.integer "management_expense", default: 0
    t.decimal "cap_rate", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "number"
    t.integer "monthly_rent"
    t.boolean "is_vacant"
    t.decimal "bedroom_count", precision: 3, scale: 1
    t.decimal "bathroom_count", precision: 3, scale: 1
    t.integer "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_units_on_number", unique: true
    t.index ["property_id"], name: "index_units_on_property_id"
  end

end
