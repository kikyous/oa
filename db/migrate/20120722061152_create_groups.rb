class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name , :null => false
      t.string :org_group_access ,:default => ""
      t.string :org_user_access ,:default => ""

      t.timestamps
    end
  end
end
