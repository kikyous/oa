class User < ActiveRecord::Base
  acts_as_messageable

  has_many :announcements
  has_many :notes
  has_and_belongs_to_many :groups
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password,:password_confirmation, :remember_me
  attr_accessible :group_ids
  # attr_accessible :title, :body
end
