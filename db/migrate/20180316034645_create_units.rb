class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :number
      t.integer :monthly_rent
      t.boolean :is_vacant
      t.decimal :bedroom_count, precision: 3, scale: 1
      t.decimal :bathroom_count, precision: 3, scale: 1
      t.references :property, foreign_key: true

      t.timestamps
    end
    add_index :units, [:number, :property_id], unique: true
  end
end
