class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :bankname
      t.string :accountname
      t.decimal :over

      t.timestamps
    end
  end
end
