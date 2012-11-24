#!/bin/env ruby
# encoding: utf-8
class InCome < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :mode, :money, :from ,:fromtime ,:bank_account_id
=======
  attr_accessible :mode, :money, :payer, :bank_account_id
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
  belongs_to :bank_account
  has_one :acceptance

end
