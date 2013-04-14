require 'rating_logic.rb'
class UserAnswers < ActiveRecord::Base
  extend RatingLogic
  belongs_to :user
  belongs_to :answer
  
  validates_presence_of :user_id, :answer_id, :rating
  validates_numericality_of :user_id, :answer_id, :rating
  validates_uniqueness_of :answer_id, :scope => [:user_id]
  validates_inclusion_of :rating, :in => [1,-1]
  

end
