class Delivery < ActiveRecord::Base
  attr_accessible :caption ,:to,:goods,:attach_ids
end
