#!/bin/env ruby
# encoding: utf-8
class TransfersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "table", :only => [:index]
  # GET /transfers
  # GET /transfers.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: TransfersDatatable.new(view_context) }
    end
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
    @transfer = Transfer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transfer }
    end
  end

  # GET /transfers/new
  # GET /transfers/new.json
  def new
    @transfer = Transfer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transfer }
    end
  end

  # GET /transfers/1/edit
  def edit
    @transfer = Transfer.find(params[:id])
  end

  # POST /transfers
  # POST /transfers.json
  def create
    begin
      params[:transfer][:attach_ids]=params[:transfer][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    
    @transfer=Transfer.new(params[:transfer])
    respond_to do |format|
      if @transfer.save
        format.html { redirect_to transfers_url, notice: '转帐单 成功创建.' }
        format.json { render json: @transfer, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /transfers/1
  # PUT /transfers/1.json
  def update
    begin
      params[:transfer][:attach_ids]=params[:transfer][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach

    @transfer = Transfer.find(params[:id])
    respond_to do |format|
      if @transfer.update_attributes(params[:transfer])
        format.html { redirect_to @transfer, notice: '转帐单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    @transfer = Transfer.find(params[:id])
    @transfer.destroy

    respond_to do |format|
      format.html { redirect_to transfers_url }
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

