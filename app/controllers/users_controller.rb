#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to users_url, :alert => '您没有权限进行此操作'
  end

  layout "table", :only => [:index]

  def index
    respond_to do |format|
      format.html
      format.json { render json: UsersDatatable.new(view_context) }
    end
  end

  def archive
    id=params[:id].to_i * 10
    @users=User.limit(10).offset(id)
    @count=User.count
    # authorize! :read, User
  end

  def new
    @groups=Group.all
    @user=User.new
    authorize! :create, @user
  end

  # POST /resource
  def create
    @user = User.new(params[:user])
    authorize! :create, @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url , notice: '用户 被成功创建.'}
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

    # GET /resource/edit
  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
    @groups=Group.all
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: '用户 被成功修改.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource
  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url , notice: '用户 被成功删除 .'}
      format.json { head :no_content }
    end

  end





end
