#!/bin/env ruby
# encoding: utf-8

class SuplContractsController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]

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
    supl_contract = SuplContract.new(params[:supl_contract])
    if supl_contract.save
      flash[:notice] = "合同成功创建！"
      redirect_to supl_contracts_path
    else
      #todo handle error
      render :json => { :result => 'error'}, :content_type => 'text/html'
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
    if @supl_contract.update_attributes(params[:supl_contract])
      flash[:notice] = "合同编辑成功！"
      redirect_to supl_contracts_path
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
