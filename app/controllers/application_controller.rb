#!/bin/env ruby
# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  rescue_from CanCan::AccessDenied do |exception|
    render :text=>'您没有权限进行此操作!'
  end
end
