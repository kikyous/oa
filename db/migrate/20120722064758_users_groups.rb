class UsersGroups < ActiveRecord::Migration
  def up
    create_table :groups_users, :id => false do |t|
      t.integer :user_id, :null => false
      t.integer :group_id, :null => false
    end
  end

  def down
  end
end
