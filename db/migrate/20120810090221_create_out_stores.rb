class CreateOutStores < ActiveRecord::Migration
  def change
    create_table :out_stores do |t|
      t.text :caption
      t.string :name
      t.string :person

      t.string :attach_ids
      t.timestamps
    end
  end
end
