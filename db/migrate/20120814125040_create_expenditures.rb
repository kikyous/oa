class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.decimal :money
      t.string :payto
      t.integer :mode

      t.references :bank_account

      t.timestamps
    end
  end
end
