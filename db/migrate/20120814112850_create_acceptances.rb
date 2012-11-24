class CreateAcceptances < ActiveRecord::Migration
  def change
    create_table :acceptances do |t|
      t.decimal :money
      t.string :bank
      t.date :expire
      t.string :unit
      t.string :number
      t.integer :status
      t.references :in_come
      t.references :expenditure

      t.timestamps
    end
  end
end
