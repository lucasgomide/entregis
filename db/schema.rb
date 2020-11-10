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

ActiveRecord::Schema.define(version: 2020_11_08_064521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "carriers", force: :cascade do |t|
    t.geography "current_location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.geometry "coverage_area", limit: {:srid=>0, :type=>"multi_polygon"}
    t.string "status", null: false
    t.integer "km_price_cents", default: 0, null: false
    t.string "km_price_currency", default: "BRL", null: false
    t.integer "weight_price_cents", default: 0, null: false
    t.string "weight_price_currency", default: "BRL", null: false
    t.bigint "shipping_carrier_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coverage_area"], name: "index_carriers_on_coverage_area", using: :gist
    t.index ["current_location"], name: "index_carriers_on_current_location", using: :gist
    t.index ["shipping_carrier_id"], name: "index_carriers_on_shipping_carrier_id"
    t.index ["vehicle_id"], name: "index_carriers_on_vehicle_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "freight_items", force: :cascade do |t|
    t.integer "cubic_meters", null: false
    t.integer "weight", null: false
    t.bigint "freight_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freight_id"], name: "index_freight_items_on_freight_id"
  end

  create_table "freights", force: :cascade do |t|
    t.geography "origin", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.geography "destination", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.integer "cubic_meters_total", null: false
    t.integer "weight_total", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination"], name: "index_freights_on_destination", using: :gist
    t.index ["origin"], name: "index_freights_on_origin", using: :gist
  end

  create_table "shipment_modes", force: :cascade do |t|
    t.string "name", null: false
    t.integer "cube_factor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_carriers", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shippments", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.string "status", null: false
    t.string "message"
    t.bigint "company_id", null: false
    t.bigint "freight_id", null: false
    t.bigint "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_shippments_on_carrier_id"
    t.index ["company_id"], name: "index_shippments_on_company_id"
    t.index ["freight_id"], name: "index_shippments_on_freight_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "cubic_meters_capacity", null: false
    t.integer "payload_capacity", null: false
    t.bigint "shipment_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipment_mode_id"], name: "index_vehicles_on_shipment_mode_id"
  end

  add_foreign_key "carriers", "shipping_carriers"
  add_foreign_key "carriers", "vehicles"
  add_foreign_key "freight_items", "freights"
  add_foreign_key "shippments", "carriers"
  add_foreign_key "shippments", "companies"
  add_foreign_key "shippments", "freights"
  add_foreign_key "vehicles", "shipment_modes"
end
