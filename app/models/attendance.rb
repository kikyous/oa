class Attendance < ActiveRecord::Base
  attr_accessible :caption,:attach_ids,:user_id,:for_month,:money
  belongs_to :user
end
