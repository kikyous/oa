#!/bin/env ruby
# encoding: utf-8
class ClientsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json { render json: ClientsDatatable.new(view_context) }
    end
  end

  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @Client }
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(params[:client])
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_url, notice: '客户 成功创建.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @client = Client.find(params[:id])
    if @Client.update_attributes(params[:client])
      flash[:notice] = "Successfully updated picture."
      redirect_to root_path
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url

  end

  def edit
    @client = Client.find(params[:id])
  end

end
