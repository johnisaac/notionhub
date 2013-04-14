class TopicUser < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  
  validates_presence_of :topic_id, :user_id
  validates_numericality_of :topic_id, :user_id
  validates_uniqueness_of :topic_id, :scope => [ :user_id ]
end
