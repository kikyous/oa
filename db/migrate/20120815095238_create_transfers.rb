class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.decimal :money
      t.text :caption
      t.string :attach_ids

      t.timestamps
    end
  end
end
