class Attendance < ActiveRecord::Base
  attr_accessible :caption,:attach_ids,:user_id,:for_month,:money
  belongs_to :user

  def self.unattendance_user(for_month)
      User.all-Attendance.includes(:user).where("attendances.for_month==?",for_month).map{|a| a.user}
  end

end
