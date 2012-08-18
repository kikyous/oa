class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :bankname
      t.string :accountname
      t.decimal :over ,:default => 0

      t.timestamps
    end
  end
end
