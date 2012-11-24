class CreateInComes < ActiveRecord::Migration
  def change
    create_table :in_comes do |t|
      t.decimal :money
      t.string :payer
      t.integer :mode
<<<<<<< HEAD
      t.string :from
      t.date :fromtime
=======

>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
      t.references :bank_account

      t.timestamps
    end
  end
end
