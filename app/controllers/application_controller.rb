class ApplicationController < ActionController::Base
  protect_from_forgery
  def require_admin_access
    unless current_user and current_user.gid==1000
      render :text => "no access permission!"
    end
  end
  
end
