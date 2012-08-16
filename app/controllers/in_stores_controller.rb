#!/bin/env ruby
# encoding: utf-8
class InStoresController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "table", :only => [:index]

  # GET /in_stores
  # GET /in_stores.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: InStoresDatatable.new(view_context) }
    end
  end

  # GET /in_stores/1
  # GET /in_stores/1.json
  def show
    @in_store = InStore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @in_store }
    end
  end

  # GET /in_stores/new
  # GET /in_stores/new.json
  def new
    @in_store = InStore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @in_store }
    end
  end

  # GET /in_stores/1/edit
  def edit
    @in_store = InStore.find(params[:id])
  end

  # POST /in_stores
  # POST /in_stores.json
  def create
    begin
      params[:in_store][:attach_ids]=params[:in_store][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    
    @in_store=InStore.new(params[:in_store])
    respond_to do |format|
      if @in_store.save
        format.html { redirect_to in_stores_url, notice: '入库单 成功创建.' }
        format.json { render json: @in_store, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @in_store.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /in_stores/1
  # PUT /in_stores/1.json
  def update
    begin
      params[:in_store][:attach_ids]=params[:in_store][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach

    @in_store = InStore.find(params[:id])
    respond_to do |format|
      if @in_store.update_attributes(params[:in_store])
        format.html { redirect_to @in_store, notice: '入库单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @in_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_stores/1
  # DELETE /in_stores/1.json
  def destroy
    @in_store = InStore.find(params[:id])
    @in_store.destroy

    respond_to do |format|
      format.html { redirect_to in_stores_url }
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

