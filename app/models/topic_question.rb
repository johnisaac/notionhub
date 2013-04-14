class TopicQuestion < ActiveRecord::Base
  belongs_to :topic
  belongs_to :question
  
  
  validates_presence_of :topic_id, :question_id
  validates_numericality_of :topic_id, :question_id
  validates_uniqueness_of :topic_id, :scope => [ :question_id ]
end
