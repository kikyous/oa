class BankAccount < ActiveRecord::Base
  attr_accessible :accountname, :bankname, :over
  has_many :in_comes

  def name
    "#{bankname} #{accountname}"
  end
end
