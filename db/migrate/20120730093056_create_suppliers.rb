class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :goods
      t.string :name
      t.string :contact
      t.string :contact_person
      t.string :address

      t.timestamps
    end

  end
end
