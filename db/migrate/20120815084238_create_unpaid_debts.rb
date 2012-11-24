class CreateUnpaidDebts < ActiveRecord::Migration
  def change
    create_table :unpaid_debts do |t|
      t.decimal :money
      t.text :caption
<<<<<<< HEAD
      t.string :number
=======
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
      t.integer :status,:default => 0

      t.references :group
      t.timestamps
    end
  end
end
