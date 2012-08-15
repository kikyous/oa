class Acceptance < ActiveRecord::Base
  attr_accessible :bank, :expire, :money, :unit, :status
  belongs_to :in_come
end
