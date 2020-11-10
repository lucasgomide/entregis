class CreateShippments < ActiveRecord::Migration[5.2]
  def change
    create_table :shippments do |t|
      t.monetize :price, null: false
      t.string :status, null: false
      t.string :message
      t.references :customer, foreign_key: true, null: false
      t.references :freight, foreign_key: true, null: false
      t.references :carrier, foreign_key: true, null: false

      t.timestamps
    end
  end
end
