class Attach < ActiveRecord::Base
  # belongs_to :supl_contract
  attr_accessible :picture
  
  has_attached_file :picture
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => [ 'image/jpeg', 'image/png', 'image/pjpeg' ]
  
end
