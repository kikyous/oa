class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.text :caption
      t.string :client
      t.string :goods
      t.string :attach_ids

      t.timestamps
    end
  end
end
