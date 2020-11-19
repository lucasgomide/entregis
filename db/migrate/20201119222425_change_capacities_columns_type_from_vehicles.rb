class ChangeCapacitiesColumnsTypeFromVehicles < ActiveRecord::Migration[5.2]
  def change
    change_column :vehicles, :cubic_meters_capacity, :float
    change_column :vehicles, :payload_capacity, :float
  end
end
