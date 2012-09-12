#!/bin/env ruby
# encoding: utf-8
class AttendancesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:personal,:show]
  # GET /attendances
  # GET /attendances.json
  def index
    respond_to do |format|
      format.html
      format.js
      format.json { render json: AttendancesDatatable.new(view_context) }
    end
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/new
  # GET /attendances/new.json
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
    @attendance = Attendance.find(params[:id])
  end

  # POST /attendances
  # POST /attendances.json

  def create
    begin
      params[:attendance][:attach_ids]=params[:attendance][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    Attendance.create(params[:attendance])

    respond_to do |format|
      format.html { redirect_to attendances_url, notice: '考勤 新建成功.' }
    end

  end

  # PUT /attendances/1
  # PUT /attendances/1.json
  def update
    begin
      params[:attendance][:attach_ids]=params[:attendance][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      if @attendance.update_attributes(params[:attendance])
        format.html { redirect_to @attendance, notice: '考勤 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url }
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
