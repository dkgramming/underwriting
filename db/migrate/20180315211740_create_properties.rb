class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :address, null: false
      t.integer :marketing_expense, default: 0
      t.integer :tax_expense, default: 0
      t.integer :insurance_expense, default: 0
      t.integer :repair_expense, default: 0
      t.integer :admin_expense, default: 0
      t.integer :payroll_expense, default: 0
      t.integer :utility_expense, default: 0
      t.integer :management_expense, default: 0
      t.decimal :cap_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
