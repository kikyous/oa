class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.text :caption
      t.string   :attach_ids
      t.date  :for_month

      t.timestamps
    end
  end
end
