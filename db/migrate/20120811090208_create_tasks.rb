class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :caption
      t.string :attach_ids

      t.timestamps
    end
  end
end
