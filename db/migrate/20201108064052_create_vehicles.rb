class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :name, null: false
      t.integer :cubic_meters_capacity, null: false
      t.integer :payload_capacity, null: false
      t.references :shipment_mode, foreign_key: true, null: false

      t.timestamps
    end
  end
end
