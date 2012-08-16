#!/bin/env ruby
# encoding: utf-8
class TasksController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]
  # GET /tasks
  # GET /tasks.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: TasksDatatable.new(view_context) }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    begin
      params[:task][:attach_ids]=params[:task][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    
    @task=Task.new(params[:task])
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: '库房任务 成功创建.' }
        format.json { render json: @task, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    begin
      params[:task][:attach_ids]=params[:task][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach

    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: '库房任务 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private

  def rm_unneed_attach()
    begin
      Attach.find(params[:unneed_attach][:attach_ids]).each do |a|
        a.destroy
      end
    rescue => err
      p err
    end
  end
end
