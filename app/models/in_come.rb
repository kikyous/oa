#!/bin/env ruby
# encoding: utf-8
class InCome < ActiveRecord::Base
  attr_accessible :mode, :money, :from ,:fromtime ,:bank_account_id
  belongs_to :bank_account
  has_one :acceptance

end
