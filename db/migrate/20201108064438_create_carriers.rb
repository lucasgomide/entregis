class CreateCarriers < ActiveRecord::Migration[5.2]
  def change
    create_table :carriers do |t|
      t.st_point :current_location, geographic: true
      t.multi_polygon :coverage_area
      t.string :status, null: false
      t.monetize :km_price, null: false
      t.monetize :weight_price, null: false
      t.references :shipping_carrier, foreign_key: true, null: false
      t.references :vehicle, foreign_key: true, null: false

      t.timestamps
    end

    add_index :carriers, :current_location, using: :gist
    add_index :carriers, :coverage_area, using: :gist
  end
end
