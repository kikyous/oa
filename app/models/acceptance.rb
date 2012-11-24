#!/bin/env ruby
# encoding: utf-8
class Acceptance < ActiveRecord::Base
  attr_accessible :bank, :expire, :unit, :status ,:expenditure_id ,:number
  belongs_to :in_come
  belongs_to :expenditure

  def name
    "#{bank} #{in_come.money}"
  end

  def self.All
      self.where(:status=>nil)
  end
end
