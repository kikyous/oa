class CreateReimbursements < ActiveRecord::Migration
  def change
    create_table :reimbursements do |t|
      t.decimal :money
      t.text :caption
      t.string :category
      t.integer :status,:default => 0

      t.references :user
      t.timestamps
    end
  end
end
