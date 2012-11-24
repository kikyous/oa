class CreateAcceptances < ActiveRecord::Migration
  def change
    create_table :acceptances do |t|
      t.decimal :money
      t.string :bank
      t.date :expire
      t.string :unit
<<<<<<< HEAD
      t.string :number
=======
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
      t.integer :status
      t.references :in_come
      t.references :expenditure

      t.timestamps
    end
  end
end
