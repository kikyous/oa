#!/bin/env ruby
# encoding: utf-8
class InComesController < ApplicationController
  layout "table", :only => [:index]
  # GET /in_comes
  # GET /in_comes.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: InComesDatatable.new(view_context) }
    end
  end

  # GET /in_comes/1
  # GET /in_comes/1.json
  def show
    @in_come = InCome.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @in_come }
    end
  end

  # GET /in_comes/new
  # GET /in_comes/new.json
  def new
    @in_come = InCome.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @in_come }
    end
  end

  # GET /in_comes/1/edit
  def edit
    @in_come = InCome.find(params[:id])
  end

  # POST /in_comes
  # POST /in_comes.json
  def create
    @in_come = InCome.create(params[:in_come])
    if params[:in_come][:mode].to_i==1
        account=@in_come.bank_account
        account.over+=(params[:in_come][:money]).to_i
        account.save
    elsif params[:in_come][:mode].to_i==2
        @in_come.update_attribute(:money,params[:acceptance][:money])
        @acceptance=@in_come.create_acceptance(params[:acceptance])
    end
        

    respond_to do |format|
      if @in_come
        format.html { redirect_to in_comes_url, notice: 'In come was successfully created.' }
        format.json { render json: @in_come, status: :created, location: @in_come }
      else
        format.html { render action: "new" }
        format.json { render json: @in_come.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /in_comes/1
  # PUT /in_comes/1.json
  def update
    @in_come = InCome.find(params[:id])
    in_come=@in_come.update_attributes(params[:in_come])
    if params[:in_come][:mode].to_i==2
        @in_come.update_attribute(:money,params[:acceptance][:money])
        acceptance=@in_come.acceptance
        if acceptance
           acceptance.update_attributes(params[:acceptance])
        else
           acceptance=@in_come.create_acceptance(params[:acceptance])
        end
    end

    respond_to do |format|
      if in_come
        format.html { redirect_to @in_come, notice: 'In come was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @in_come.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_comes/1
  # DELETE /in_comes/1.json
  def destroy
    @in_come = InCome.find(params[:id])
    @in_come.destroy

    respond_to do |format|
      format.html { redirect_to in_comes_url }
      format.json { head :no_content }
    end
  end
end
