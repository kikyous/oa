class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.text :caption
      t.references :user
      t.string   :attach_ids
      t.string  :for_month
      t.decimal  :money, :default => 0

      t.timestamps
    end
    add_index :attendances, :user_id
  end
end
