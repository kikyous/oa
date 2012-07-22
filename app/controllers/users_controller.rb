class UsersController < ApplicationController
  before_filter :require_admin_access
  layout "table", :only => [:index]
  def index
  end

  def show
   @users=User.limit(10).offset(params[:id].to_i)
  end

  def new
    @groups=Group.all
    @user=User.new
    # resource = build_resource({})
    # respond_with resource
  end

  # POST /resource
  def create
    resource = User.new(params[:user])
    if resource.save
      render :json => {:name=> resource}
    else
      render :text => 'Failure !'
    end
  end

    # GET /resource/edit
  def edit
    @user = User.find(params[:id])
    @groups=Group.all
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    @user = User.find(params[:id])
    if @user.update_with_password(params[:user])
      render :text => 'User was successfully updated.'
    else
      render :text => 'Failure !'
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end





end
