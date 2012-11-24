class UnpaidDebt < ActiveRecord::Base
  attr_accessible :caption, :money, :status ,:group_id ,:number
  belongs_to :group
end
