class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :goods
      t.string :contact
      t.string :contact_person
      t.string :address

      t.timestamps
    end

  end
end
