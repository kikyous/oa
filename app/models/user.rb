#!/bin/env ruby
# encoding: utf-8
class User < ActiveRecord::Base
  acts_as_messageable

  has_many :announcements
  has_many :notes
  has_many :reimbursements
  has_and_belongs_to_many :groups
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :name, :password,:password_confirmation, :remember_me
  attr_accessible :group_ids

  validates_uniqueness_of :username,:on=>:create,:message=>"用户名已被使用!"
end
