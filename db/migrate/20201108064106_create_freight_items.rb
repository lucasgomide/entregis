class CreateFreightItems < ActiveRecord::Migration[5.2]
  def change
    create_table :freight_items do |t|
      t.integer :cubic_meters, null: false
      t.integer :weight, null: false
      t.references :freight, foreign_key: true, null: false

      t.timestamps
    end
  end
end
