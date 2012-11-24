class Delivery < ActiveRecord::Base
  attr_accessible :caption ,:client,:goods,:attach_ids
end
