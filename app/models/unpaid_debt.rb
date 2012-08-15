class UnpaidDebt < ActiveRecord::Base
  attr_accessible :caption, :money, :status ,:group_id
  belongs_to :group
end
