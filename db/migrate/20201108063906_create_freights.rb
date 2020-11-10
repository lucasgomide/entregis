class CreateFreights < ActiveRecord::Migration[5.2]
  def change
    create_table :freights do |t|
      t.st_point :origin, geographic: true, null: false
      t.st_point :destination, geographic: true, null: false
      t.integer :cubic_meters_total, null: false
      t.integer :weight_total, null: false

      t.timestamps
    end

    add_index :freights, :origin, using: :gist
    add_index :freights, :destination, using: :gist
  end
end
