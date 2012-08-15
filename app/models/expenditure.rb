class Expenditure < ActiveRecord::Base
  attr_accessible :mode, :money, :payer, :bank_account_id
  belongs_to :bank_account
  has_one :acceptance
end
