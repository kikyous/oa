class UsersController < ApplicationController
  before_filter :require_admin_access
  layout "table", :only => [:index]
  def index
  end

  def show
    id=params[:id].to_i * 10
   @users=User.limit(10).offset(id)
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
      redirect_to users_url
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
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    p params
    p params[:user]
    if @user.update_attributes(params[:user])
      render :text => 'User was successfully updated.'
    else
      render :text => 'Failure !'
    end
  end

  # DELETE /resource
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url

  end





end
