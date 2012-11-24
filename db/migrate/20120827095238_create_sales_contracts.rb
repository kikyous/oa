class CreateSalesContracts < ActiveRecord::Migration
  def change
    create_table :sales_contracts do |t|
      t.decimal :money
      t.string :name
      t.string :client
      t.text :caption
      t.string :attach_ids
<<<<<<< HEAD
      t.references :client
=======
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb

      t.timestamps
    end
  end
end
