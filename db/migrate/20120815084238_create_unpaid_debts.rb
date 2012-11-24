class CreateUnpaidDebts < ActiveRecord::Migration
  def change
    create_table :unpaid_debts do |t|
      t.decimal :money
      t.text :caption
      t.string :number
      t.integer :status,:default => 0

      t.references :group
      t.timestamps
    end
  end
end
