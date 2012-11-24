class SuplContract < ActiveRecord::Base
  belongs_to :supplier
  attr_accessible :caption,:supplier_id,:attach_ids,:name,:money
  # has_many :attaches
end
