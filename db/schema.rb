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

ActiveRecord::Schema.define(version: 2020_11_24_131741) do

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
    t.float "available_cubic_meters", null: false
    t.float "available_payload", null: false
    t.index ["coverage_area"], name: "index_carriers_on_coverage_area", using: :gist
    t.index ["current_location"], name: "index_carriers_on_current_location", using: :gist
    t.index ["shipping_carrier_id"], name: "index_carriers_on_shipping_carrier_id"
    t.index ["vehicle_id"], name: "index_carriers_on_vehicle_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", limit: 14, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_customers_on_document", unique: true
  end

  create_table "freight_items", force: :cascade do |t|
    t.float "cubic_meters", null: false
    t.float "weight", null: false
    t.bigint "freight_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freight_id"], name: "index_freight_items_on_freight_id"
  end

  create_table "freights", force: :cascade do |t|
    t.geography "origin", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.geography "destination", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.float "cubic_meters_total", null: false
    t.float "weight_total", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination"], name: "index_freights_on_destination", using: :gist
    t.index ["origin"], name: "index_freights_on_origin", using: :gist
  end

  create_table "shipment_modes", force: :cascade do |t|
    t.string "name", null: false
    t.float "cube_factor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.string "status", null: false
    t.string "message"
    t.bigint "customer_id", null: false
    t.bigint "freight_id", null: false
    t.bigint "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_shipments_on_carrier_id"
    t.index ["customer_id"], name: "index_shipments_on_customer_id"
    t.index ["freight_id"], name: "index_shipments_on_freight_id"
  end

  create_table "shipping_carriers", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", limit: 14, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_shipping_carriers_on_document", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "name", null: false
    t.float "cubic_meters_capacity", null: false
    t.float "payload_capacity", null: false
    t.bigint "shipment_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipment_mode_id"], name: "index_vehicles_on_shipment_mode_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "carriers", "shipping_carriers"
  add_foreign_key "carriers", "vehicles"
  add_foreign_key "freight_items", "freights"
  add_foreign_key "shipments", "carriers"
  add_foreign_key "shipments", "customers"
  add_foreign_key "shipments", "freights"
  add_foreign_key "vehicles", "shipment_modes"
end
