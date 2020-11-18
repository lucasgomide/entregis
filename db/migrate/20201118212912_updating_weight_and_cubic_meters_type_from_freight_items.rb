class UpdatingWeightAndCubicMetersTypeFromFreightItems < ActiveRecord::Migration[5.2]
  def change
    change_column :freight_items, :cubic_meters, :float
    change_column :freight_items, :weight, :float
  end
end
