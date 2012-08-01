#!/bin/env ruby
# encoding: utf-8

class AttachesController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    attach = Attach.new(params[:attach])
    if attach.save
      render :json => { :a_path => attach.picture.url.to_s , :name => attach.picture.instance.attributes["picture_file_name"] , :size => attach.picture.instance.attributes["picture_file_size"],:id=>attach.id}
    else
      render :json => { :error => true ,:msg => '发生错误'}
    end
  end

  def destroy
    @attach = Attach.find(params[:id])
    @attach.destroy
  end
end
