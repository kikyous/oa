class ApplicationController < ActionController::Base
  protect_from_forgery
  def require_admin_access
    unless current_user 
      render :text => "no access permission!"
    end
  end
  
end
