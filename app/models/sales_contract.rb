class SalesContract < ActiveRecord::Base
  attr_accessible :caption,:attach_ids,:name,:money,:to
  # has_many :attaches
end
