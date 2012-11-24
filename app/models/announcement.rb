class Announcement < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content
end
