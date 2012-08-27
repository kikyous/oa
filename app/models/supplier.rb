class Supplier < ActiveRecord::Base
  has_many :supl_contracts
  attr_accessible :name ,:goods ,:address ,:contact ,:contact_person

end
