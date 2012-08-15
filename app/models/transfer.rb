class Transfer < ActiveRecord::Base
  attr_accessible :caption ,:attach_ids ,:money
  has_many :acceptances
end
