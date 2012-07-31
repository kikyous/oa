class CreateAttaches < ActiveRecord::Migration
  def self.up
    create_table :attaches do |t|
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_file_size
      t.datetime :picture_updated_at
      t.references :supl_contract
      t.timestamps
    end
  end

  def self.down
    drop_table :attaches
  end
end
