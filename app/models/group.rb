class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name ,:org_group_access ,:org_user_access
  has_many :unpaid_debts
end
