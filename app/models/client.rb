class Client < ActiveRecord::Base
  has_many :sales_contracts
  attr_accessible :name ,:goods ,:address ,:contact ,:contact_person

end