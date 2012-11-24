class SalesContract < ActiveRecord::Base
  belongs_to :client
  attr_accessible :caption,:attach_ids,:name,:money,:client,:client_id
  # has_many :attaches
end
