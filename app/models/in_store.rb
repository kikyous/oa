class InStore < ActiveRecord::Base
  attr_accessible :caption ,:attach_ids
  has_many :acceptances
end
