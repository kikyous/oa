#!/bin/env ruby
# encoding: utf-8

class GroupsController < ApplicationController
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to groups_url, :alert => '您没有权限进行此操作'
  end

  layout "table", :only => [:index]
  # GET /groups
  # GET /groups.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: GroupsDatatable.new(view_context) }
    end
  end


  # GET /groups/1
  # GET /groups/1.json
  def archive
    id=params[:id].to_i * 10
    @groups=Group.limit(10).offset(id)
    @count=Group.count
    # authorize! :read, Group

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    authorize! :create, @group

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    authorize! :update, @group
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    authorize! :create, @group

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url , notice: '机构 被成功创建.'}
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])
    authorize! :update, @group

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to groups_url, notice: '机构 被成功修改.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    authorize! :destroy, @group
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url , notice: '机构 被成功删除 .'}
      format.json { head :no_content }
    end
  end
end
