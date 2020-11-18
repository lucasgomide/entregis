class UpdatingWeightAndCubicMetersTypeFromFreight < ActiveRecord::Migration[5.2]
  def change
    change_column :freights, :cubic_meters_total, :float
    change_column :freights, :weight_total, :float
  end
end
