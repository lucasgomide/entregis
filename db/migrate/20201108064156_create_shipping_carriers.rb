class CreateShippingCarriers < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_carriers do |t|
      t.string :name, null: false
      t.string :document, null: false

      t.timestamps
    end
  end
end
