class CreateSuplContracts < ActiveRecord::Migration
  def change
    create_table :supl_contracts do |t|
      t.text :caption
      t.string :name
      t.decimal :money
      t.references :supplier
      t.string   :attach_ids

      t.timestamps
    end
    add_index :supl_contracts, :supplier_id
  end
end
