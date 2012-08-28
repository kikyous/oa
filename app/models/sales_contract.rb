class SalesContract < ActiveRecord::Base
  attr_accessible :caption,:attach_ids,:name,:money,:client
  # has_many :attaches
end
