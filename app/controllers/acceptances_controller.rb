#!/bin/env ruby
# encoding: utf-8
class AcceptancesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /acceptances
  # GET /acceptances.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: AcceptancesDatatable.new(view_context) }
    end
  end

  # GET /acceptances/1
  # GET /acceptances/1.json
  def show
    @acceptance = Acceptance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @acceptance }
    end
  end

  # GET /acceptances/new
  # GET /acceptances/new.json
  def new
    @acceptance = Acceptance.new

    respond_to do |format|
      format.html { render :layout=>false}
      format.json { render json: @acceptance }
    end
  end

  # GET /acceptances/1/edit
  def edit
    @acceptance = Acceptance.find(params[:id])
  end

  # POST /acceptances
  # POST /acceptances.json
  def create
    @acceptance = Acceptance.new(params[:acceptance])

    respond_to do |format|
      if @acceptance.save
        format.html { redirect_to @acceptance, notice: '承兑 成功创建.' }
        format.json { render json: @acceptance, status: :created, location: @acceptance }
      else
        format.html { render action: "new" }
        format.json { render json: @acceptance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /acceptances/1
  # PUT /acceptances/1.json
  def update
    @acceptance = Acceptance.find(params[:id])

    respond_to do |format|
      if @acceptance.update_attributes(params[:acceptance])
        format.html { redirect_to @acceptance, notice: '承兑 成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @acceptance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acceptances/1
  # DELETE /acceptances/1.json
  def destroy
    @acceptance = Acceptance.find(params[:id])
    @acceptance.destroy

    respond_to do |format|
      format.html { redirect_to acceptances_url }
      format.json { head :no_content }
    end
  end
end
