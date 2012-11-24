module ApplicationHelper
  def isManager?
    current_user.groups.map(&:id).include?(2)
  end
end
