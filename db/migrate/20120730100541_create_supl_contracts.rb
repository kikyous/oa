class CreateSuplContracts < ActiveRecord::Migration
  def change
    create_table :supl_contracts do |t|
      t.string :caption
      t.references :supplier

      t.timestamps
    end
    add_index :supl_contracts, :supplier_id
  end
end
