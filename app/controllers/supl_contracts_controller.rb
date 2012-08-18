#!/bin/env ruby
# encoding: utf-8

class SuplContractsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json { render json: SuplContractsDatatable.new(view_context) }
    end
  end

  def new
    @supl_contract = SuplContract.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supl_contract }
    end
  end


  def show
    @supl_contract = SuplContract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supl_contract }
    end
  end


  def edit
    @supl_contract = SuplContract.find(params[:id])
  end
  
  def create
    begin
      params[:supl_contract][:attach_ids]=params[:supl_contract][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach 
    @supl_contract = SuplContract.new(params[:supl_contract])
    respond_to do |format|
      if @supl_contract.save
        format.html { redirect_to supl_contracts_url, notice: '供应合同 成功创建.' }
        format.json { render json: @supl_contract, status: :created, location: @supl_contract }
      else
        format.html { render action: "new" }
        format.json { render json: @supl_contract.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    begin
      params[:supl_contract][:attach_ids]=params[:supl_contract][:attach_ids].join(",")
    rescue => err
      p err
    end

    rm_unneed_attach 
    @supl_contract = SuplContract.find(params[:id])
    respond_to do |format|
      if @supl_contract.update_attributes(params[:supl_contract])
        format.html { redirect_to supl_contracts_url, notice: '供应合同 成功更改.' }
        format.json { render json: @supl_contract, status: :created, location: @supl_contract }
      else
        format.html { render action: "new" }
        format.json { render json: @supl_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @supl_contract = SuplContract.find(params[:id])
    @supl_contract.destroy
    redirect_to supl_contracts_url

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
