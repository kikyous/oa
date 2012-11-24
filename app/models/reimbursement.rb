class Reimbursement < ActiveRecord::Base
  attr_accessible :caption, :money, :status ,:user_id ,:category
  belongs_to :user
end
