class ChangeCubeFactorFieldTypeFromShipmentMode < ActiveRecord::Migration[5.2]
  def change
    change_column :shipment_modes, :cube_factor, :float
  end
end
