class AddIndexToDocumentToCustomerName < ActiveRecord::Migration[5.2]
  def change
    add_index :customers, :document, unique: true
  end
end
