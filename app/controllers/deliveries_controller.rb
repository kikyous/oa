#!/bin/env ruby
# encoding: utf-8
class DeliveriesController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]
  # GET /deliverys
  # GET /deliverys.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: DeliveriesDatatable.new(view_context) }
    end
  end

  # GET /deliverys/1
  # GET /deliverys/1.json
  def show
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /deliverys/new
  # GET /deliverys/new.json
  def new
    @delivery = Delivery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /deliverys/1/edit
  def edit
    @delivery = Delivery.find(params[:id])
  end

  # POST /deliverys
  # POST /deliverys.json
  def create
    begin
      params[:delivery][:attach_ids]=params[:delivery][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    
    @delivery=Delivery.new(params[:delivery])
    respond_to do |format|
      if @delivery.save
        format.html { redirect_to deliveries_url, notice: '送货单 成功创建.' }
        format.json { render json: @delivery, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /deliverys/1
  # PUT /deliverys/1.json
  def update
    begin
      params[:delivery][:attach_ids]=params[:delivery][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach

    @delivery = Delivery.find(params[:id])
    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        format.html { redirect_to @delivery, notice: '送货单 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliverys/1
  # DELETE /deliverys/1.json
  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy

    respond_to do |format|
      format.html { redirect_to deliveries_url }
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
