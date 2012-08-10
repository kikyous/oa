class CreateOutStores < ActiveRecord::Migration
  def change
    create_table :out_stores do |t|
      t.string :caption
      t.string :attach_ids

      t.timestamps
    end
  end
end
