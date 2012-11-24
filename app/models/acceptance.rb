#!/bin/env ruby
# encoding: utf-8
class Acceptance < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :bank, :expire, :unit, :status ,:expenditure_id ,:number
=======
  attr_accessible :bank, :expire, :money, :unit, :status ,:expenditure_id
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
  belongs_to :in_come
  belongs_to :expenditure

  def name
<<<<<<< HEAD
    "#{bank} #{in_come.money}"
=======
    "#{bank} #{money}"
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
  end

  def self.All
      self.where(:status=>nil)
  end
end
