class RenameShippmentTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :shippments, :shipments
  end
end
