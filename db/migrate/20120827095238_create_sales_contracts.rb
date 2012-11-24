class CreateSalesContracts < ActiveRecord::Migration
  def change
    create_table :sales_contracts do |t|
      t.decimal :money
      t.string :name
      t.string :client
      t.text :caption
      t.string :attach_ids
      t.references :client

      t.timestamps
    end
  end
end
