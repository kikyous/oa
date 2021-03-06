#!/bin/env ruby
# encoding: utf-8
class ExpendituresController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /expenditures
  # GET /expenditures.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ExpendituresDatatable.new(view_context) }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
    @expenditure = Expenditure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/new
  # GET /expenditures/new.json
  def new
    @expenditure = Expenditure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/1/edit
  def edit
    @expenditure = Expenditure.find(params[:id])
  end

  # POST /expenditures
  # POST /expenditures.json
  def create
    if params[:expenditure][:mode].to_i==1
      if params[:expenditure][:bank_account_id].blank?
        render action: "new"
        return
      end
      @expenditure = Expenditure.create(params[:expenditure])
      account=@expenditure.bank_account
      account.over-=(params[:expenditure][:money]).to_i
      account.save
    elsif params[:expenditure][:mode].to_i==2
      acceptance=Acceptance.find(params[:acceptance][:id])
      params[:expenditure][:money]=acceptance.money
      @expenditure = Expenditure.create(params[:expenditure])
      acceptance.update_attributes(:status=>1,:expenditure_id=>@expenditure.id)
    else
      @expenditure = Expenditure.create(params[:expenditure])
    end

    respond_to do |format|
      if @expenditure
        format.html { redirect_to expenditures_url, notice: '支出单 成功创建.' }
        format.json { render json: @expenditure, status: :created, location: @expenditure }
      else
        format.html { render action: "new" }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.json
  def update
    @expenditure = Expenditure.find(params[:id])
    if params[:expenditure][:mode].to_i==1
      account=@expenditure.bank_account
      account.over-=(params[:expenditure][:money]).to_i-@expenditure.money
      account.save
    end
    expenditure=@expenditure.update_attributes(params[:expenditure])
    if params[:expenditure][:mode].to_i==2
      acceptance=Acceptance.find(params[:acceptance][:id])
      acceptance.update_attribute(:status,1)
      @expenditure.update_attribute(:money,acceptance.money)
    end

    respond_to do |format|
      if expenditure
        format.html { redirect_to @expenditure, notice: '支出单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.json
  def destroy
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy

    respond_to do |format|
      format.html { redirect_to expenditures_url }
      format.json { head :no_content }
    end
  end
end
