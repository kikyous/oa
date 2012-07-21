class UsersController < ApplicationController
  before_filter :require_admin_access
  layout "table", :only => [:index]
  def index
  end
  def show
   p params[:from] 
   p params[:to] 
   @users=User.limit(10).offset(params[:from].to_i)
  end
end
