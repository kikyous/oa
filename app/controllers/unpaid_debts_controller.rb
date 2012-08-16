#!/bin/env ruby
# encoding: utf-8
class UnpaidDebtsController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]
  # GET /unpaid_debts
  # GET /unpaid_debts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: UnpaidDebtsDatatable.new(view_context) }
    end
  end

  # GET /unpaid_debts/1
  # GET /unpaid_debts/1.json
  def show
    @unpaid_debt = UnpaidDebt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unpaid_debt }
    end
  end

  # GET /unpaid_debts/new
  # GET /unpaid_debts/new.json
  def new
    @unpaid_debt = UnpaidDebt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unpaid_debt }
    end
  end

  # GET /unpaid_debts/1/edit
  def edit
    @unpaid_debt = UnpaidDebt.find(params[:id])
  end

  # POST /unpaid_debts
  # POST /unpaid_debts.json
  def create
    unless params[:unpaid_debt][:status].nil? or isManager?
      redirect_to unpaid_debts_url, :alert => '您没有权限进行此操作'
      return
    end
    @unpaid_debt = UnpaidDebt.new(params[:unpaid_debt])

    respond_to do |format|
      if @unpaid_debt.save
        format.html { redirect_to unpaid_debts_url, notice: '挂帐单 成功创建.' }
        format.json { render json: @unpaid_debt, status: :created, location: @unpaid_debt }
      else
        format.html { render action: "new" }
        format.json { render json: @unpaid_debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /unpaid_debts/1
  # PUT /unpaid_debts/1.json
  def update
    unless params[:unpaid_debt][:status].nil? or isManager?
      redirect_to unpaid_debts_url, :alert => '您没有权限进行此操作'
      return
    end
    @unpaid_debt = UnpaidDebt.find(params[:id])

    respond_to do |format|
      if @unpaid_debt.update_attributes(params[:unpaid_debt])
        format.html { redirect_to @unpaid_debt, notice: '挂帐单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unpaid_debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unpaid_debts/1
  # DELETE /unpaid_debts/1.json
  def destroy
    @unpaid_debt = UnpaidDebt.find(params[:id])
    @unpaid_debt.destroy

    respond_to do |format|
      format.html { redirect_to unpaid_debts_url }
      format.json { head :no_content }
    end
  end
end
