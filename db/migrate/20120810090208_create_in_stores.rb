class CreateInStores < ActiveRecord::Migration
  def change
    create_table :in_stores do |t|
      t.string :caption
      t.string :attach_ids

      t.timestamps
    end
  end
end
