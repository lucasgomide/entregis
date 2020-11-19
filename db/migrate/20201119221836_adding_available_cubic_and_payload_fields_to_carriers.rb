class AddingAvailableCubicAndPayloadFieldsToCarriers < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :available_cubic_meters, :float, null: false
    add_column :carriers, :available_payload, :float, null: false
  end
end
