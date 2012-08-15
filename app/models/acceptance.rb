#!/bin/env ruby
# encoding: utf-8
class Acceptance < ActiveRecord::Base
  attr_accessible :bank, :expire, :money, :unit, :status ,:expenditure_id
  belongs_to :in_come
  belongs_to :expenditure

  def name
    "#{bank} #{money}"
  end

  def self.All
      self.where(:status=>nil)
  end
end
