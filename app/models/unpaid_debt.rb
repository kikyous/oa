class UnpaidDebt < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :caption, :money, :status ,:group_id ,:number
=======
  attr_accessible :caption, :money, :status ,:group_id
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
  belongs_to :group
end
