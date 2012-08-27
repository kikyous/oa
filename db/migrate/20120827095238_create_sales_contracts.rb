class CreateSalesContracts < ActiveRecord::Migration
  def change
    create_table :sales_contracts do |t|
      t.decimal :money
      t.string :name
      t.string :to
      t.text :caption
      t.string :attach_ids

      t.timestamps
    end
  end
end
