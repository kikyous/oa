#!/bin/env ruby
# encoding: utf-8

class SalesContractsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json { render json: SalesContractsDatatable.new(view_context) }
    end
  end

  def new
    @sales_contract = SalesContract.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sales_contract }
    end
  end


  def show
    @sales_contract = SalesContract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sales_contract }
    end
  end


  def edit
    @sales_contract = SalesContract.find(params[:id])
  end
  
  def create
    begin
      params[:sales_contract][:attach_ids]=params[:sales_contract][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach 
    @sales_contract = SalesContract.new(params[:sales_contract])
    respond_to do |format|
      if @sales_contract.save
        format.html { redirect_to sales_contracts_url, notice: '供应合同 成功创建.' }
        format.json { render json: @sales_contract, status: :created, location: @sales_contract }
      else
        format.html { render action: "new" }
        format.json { render json: @sales_contract.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    begin
      params[:sales_contract][:attach_ids]=params[:sales_contract][:attach_ids].join(",")
    rescue => err
      p err
    end

    rm_unneed_attach 
    @sales_contract = SalesContract.find(params[:id])
    respond_to do |format|
      if @sales_contract.update_attributes(params[:sales_contract])
        format.html { redirect_to sales_contracts_url, notice: '供应合同 成功更改.' }
        format.json { render json: @sales_contract, status: :created, location: @sales_contract }
      else
        format.html { render action: "new" }
        format.json { render json: @sales_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sales_contract = SalesContract.find(params[:id])
    @sales_contract.destroy
    redirect_to sales_contracts_url

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
