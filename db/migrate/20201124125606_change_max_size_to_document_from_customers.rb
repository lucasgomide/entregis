class ChangeMaxSizeToDocumentFromCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :document, :string,  limit: 14
  end
end
