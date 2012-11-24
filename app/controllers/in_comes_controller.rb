#!/bin/env ruby
# encoding: utf-8
class InComesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /in_comes
  # GET /in_comes.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: InComesDatatable.new(view_context) }
    end
  end

  # GET /in_comes/1
  # GET /in_comes/1.json
  def show
    @in_come = InCome.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @in_come }
    end
  end

  # GET /in_comes/new
  # GET /in_comes/new.json
  def new
    @in_come = InCome.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @in_come }
    end
  end

  # GET /in_comes/1/edit
  def edit
    @in_come = InCome.find(params[:id])
  end

  # POST /in_comes
  # POST /in_comes.json
  def create

    if params[:in_come][:mode].to_i==1
      if params[:in_come][:bank_account_id].blank?
        render action: "new"
        return
      end
      @in_come = InCome.create(params[:in_come])
      account=@in_come.bank_account
      account.over+=(params[:in_come][:money]).to_i
      account.save
    elsif params[:in_come][:mode].to_i==2
<<<<<<< HEAD
      #params[:in_come][:money]=params[:acceptance][:money]
=======
      params[:in_come][:money]=params[:acceptance][:money]
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
      @in_come = InCome.create(params[:in_come])
      @acceptance=@in_come.create_acceptance(params[:acceptance])
    else
      @in_come = InCome.create(params[:in_come])
    end

    respond_to do |format|
      if @in_come
        format.html { redirect_to in_comes_url, notice: '收入单 成功创建.' }
        format.json { render json: @in_come, status: :created, location: @in_come }
      else
        format.html { render action: "new" }
        format.json { render json: @in_come.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /in_comes/1
  # PUT /in_comes/1.json
  def update
    @in_come = InCome.find(params[:id])
    if params[:in_come][:mode].to_i==1
      account=@in_come.bank_account
      account.over+=(params[:in_come][:money]).to_i-@in_come.money
      account.save
    end
    in_come=@in_come.update_attributes(params[:in_come])
    if params[:in_come][:mode].to_i==2
        @in_come.update_attribute(:money,params[:acceptance][:money])
        acceptance=@in_come.acceptance
        if acceptance
           acceptance.update_attributes(params[:acceptance])
        else
           acceptance=@in_come.create_acceptance(params[:acceptance])
        end
    end

    respond_to do |format|
      if in_come
        format.html { redirect_to @in_come, notice: '收入单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @in_come.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_comes/1
  # DELETE /in_comes/1.json
  def destroy
    @in_come = InCome.find(params[:id])
    @in_come.destroy

    respond_to do |format|
      format.html { redirect_to in_comes_url }
      format.json { head :no_content }
    end
  end
end
