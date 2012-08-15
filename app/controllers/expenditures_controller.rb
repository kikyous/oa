#!/bin/env ruby
# encoding: utf-8
class ExpendituresController < ApplicationController
  layout "table", :only => [:index]
  # GET /expenditures
  # GET /expenditures.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ExpendituresDatatable.new(view_context) }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
    @expenditure = Expenditure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/new
  # GET /expenditures/new.json
  def new
    @expenditure = Expenditure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/1/edit
  def edit
    @expenditure = Expenditure.find(params[:id])
  end

  # POST /expenditures
  # POST /expenditures.json
  def create
    @expenditure = Expenditure.create(params[:expenditure])
    if params[:expenditure][:mode].to_i==2
        acceptance=Acceptance.find(params[:acceptance][:id])
        acceptance.update_attribute(:status,1)
        @expenditure.update_attribute(:money,acceptance.money)
    end

    respond_to do |format|
      if @expenditure
        format.html { redirect_to @expenditure, notice: 'In come was successfully created.' }
        format.json { render json: @expenditure, status: :created, location: @expenditure }
      else
        format.html { render action: "new" }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.json
  def update
    @expenditure = Expenditure.find(params[:id])
    expenditure=@expenditure.update_attributes(params[:expenditure])
    if params[:expenditure][:mode].to_i==2
        acceptance=Acceptance.find(params[:acceptance][:id])
        acceptance.update_attribute(:status,1)
        @expenditure.update_attribute(:money,acceptance.money)
    end

    respond_to do |format|
      if expenditure
        format.html { redirect_to @expenditure, notice: 'In come was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.json
  def destroy
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy

    respond_to do |format|
      format.html { redirect_to expenditures_url }
      format.json { head :no_content }
    end
  end
end
