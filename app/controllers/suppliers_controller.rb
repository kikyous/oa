#!/bin/env ruby
# encoding: utf-8
class SuppliersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json { render json: SuppliersDatatable.new(view_context) }
    end
  end

  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier }
    end
  end


  def show
    @supplier = Supplier.find(params[:id])
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    respond_to do |format|
      if @supplier.save
        format.html { redirect_to suppliers_url, notice: '供应商 成功创建.' }
        format.json { render json: @supplier, status: :created, location: @supplier }
      else
        format.html { render action: "new" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "Successfully updated picture."
      redirect_to root_path
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to suppliers_url

  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

end
