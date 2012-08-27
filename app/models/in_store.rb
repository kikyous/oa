class InStore < ActiveRecord::Base
  attr_accessible :caption ,:name,:attach_ids
  has_many :acceptances
end
