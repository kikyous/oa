#!/bin/env ruby
# encoding: utf-8

Group.create(:name => '系统管理员')
Group.create(:name => '总经理')
Group.create(:name => '供销部')
Group.create(:name => '财务')
Group.create(:name => '库房')



u = User.new(
  :username => "admin",
  :password => '111111'
)
u.save!(:validate => false)
