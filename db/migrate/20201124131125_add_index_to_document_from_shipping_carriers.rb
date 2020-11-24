class AddIndexToDocumentFromShippingCarriers < ActiveRecord::Migration[5.2]
  def change
    add_index :shipping_carriers, :document, unique: true
  end
end
