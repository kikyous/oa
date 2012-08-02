class Attendance < ActiveRecord::Base
  attr_accessible :caption,:attach_ids,:user_id,:for_month
  belongs_to :user
end
