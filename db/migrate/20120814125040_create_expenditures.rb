class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.decimal :money
<<<<<<< HEAD
      t.string :payto
=======
      t.string :payer
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
      t.integer :mode

      t.references :bank_account

      t.timestamps
    end
  end
end
