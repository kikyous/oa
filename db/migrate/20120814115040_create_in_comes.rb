class CreateInComes < ActiveRecord::Migration
  def change
    create_table :in_comes do |t|
      t.decimal :money
      t.string :payer
      t.integer :mode

      t.references :bank_account

      t.timestamps
    end
  end
end
