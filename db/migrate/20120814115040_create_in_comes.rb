class CreateInComes < ActiveRecord::Migration
  def change
    create_table :in_comes do |t|
      t.decimal :money
      t.string :payer
      t.integer :mode
      t.string :from
      t.date :fromtime
      t.references :bank_account

      t.timestamps
    end
  end
end
