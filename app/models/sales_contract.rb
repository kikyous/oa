class SalesContract < ActiveRecord::Base
  attr_accessible :caption,:attach_ids,:name,:money,:client,:client_id
  # has_many :attaches
end
