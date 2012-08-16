#!/bin/env ruby
# encoding: utf-8
class OutStoresController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "table", :only => [:index]
  # GET /out_stores
  # GET /out_stores.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: OutStoresDatatable.new(view_context) }
    end
  end

  # GET /out_stores/1
  # GET /out_stores/1.json
  def show
    @out_store = OutStore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @out_store }
    end
  end

  # GET /out_stores/new
  # GET /out_stores/new.json
  def new
    @out_store = OutStore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @out_store }
    end
  end

  # GET /out_stores/1/edit
  def edit
    @out_store = OutStore.find(params[:id])
  end

  # POST /out_stores
  # POST /out_stores.json
  def create
    begin
      params[:out_store][:attach_ids]=params[:out_store][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    
    @out_store=OutStore.new(params[:out_store])
    respond_to do |format|
      if @out_store.save
        format.html { redirect_to out_stores_url, notice: '出库单 成功创建.' }
        format.json { render json: @out_store, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @out_store.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /out_stores/1
  # PUT /out_stores/1.json
  def update
    begin
      params[:out_store][:attach_ids]=params[:out_store][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach

    @out_store = OutStore.find(params[:id])
    respond_to do |format|
      if @out_store.update_attributes(params[:out_store])
        format.html { redirect_to @out_store, notice: '出库单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @out_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /out_stores/1
  # DELETE /out_stores/1.json
  def destroy
    @out_store = OutStore.find(params[:id])
    @out_store.destroy

    respond_to do |format|
      format.html { redirect_to out_stores_url }
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
