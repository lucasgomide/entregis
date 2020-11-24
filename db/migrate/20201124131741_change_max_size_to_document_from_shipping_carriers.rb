class ChangeMaxSizeToDocumentFromShippingCarriers < ActiveRecord::Migration[5.2]
  def change
    change_column :shipping_carriers, :document, :string,  limit: 14
  end
end
