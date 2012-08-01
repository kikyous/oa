class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :announcements, :user_id
  end
end
