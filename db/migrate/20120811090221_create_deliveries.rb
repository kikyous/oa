class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :caption
      t.string :to
      t.string :attach_ids

      t.timestamps
    end
  end
end
