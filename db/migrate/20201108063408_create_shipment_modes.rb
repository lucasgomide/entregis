class CreateShipmentModes < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_modes do |t|
      t.string :name, null: false
      t.integer :cube_factor, null: false

      t.timestamps
    end
  end
end
