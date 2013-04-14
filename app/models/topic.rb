class Topic < ActiveRecord::Base
  has_many :topic_users
  has_many :users, :through => :topic_users
  has_many :topic_questions
  has_many :topics, :through => :topic_questions
  
  validates_presence_of :name
end
