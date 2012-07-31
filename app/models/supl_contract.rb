class SuplContract < ActiveRecord::Base
  belongs_to :supplier
  attr_accessible :caption,:supplier_id,:attach_ids
  # has_many :attaches
end
