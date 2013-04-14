class AComment < ActiveRecord::Base
  belongs_to :answer
  
  validates_presence_of :user_id, :answer_id, :content
  validates_numericality_of :user_id, :answer_id
  validates_length_of :content, :minimum => 1
end
