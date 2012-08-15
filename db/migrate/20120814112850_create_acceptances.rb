class CreateAcceptances < ActiveRecord::Migration
  def change
    create_table :acceptances do |t|
      t.decimal :money
      t.string :bank
      t.datetime :expire
      t.string :unit
      t.string :status
      t.references :in_come

      t.timestamps
    end
  end
end
