class Feedback < ActiveRecord::Base
  belongs_to :user
  
  validates_numericality_of :rating, :user_id
  validates_inclusion_of :rating, :in => [2, 1, 0, -2]
  
end
