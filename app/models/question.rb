class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :topic_questions
  has_many :topics, :through => :topic_questions
  has_many :user_questions
  
  before_create do |question| 
    question.flags = 1
    question.rating = 0
  end
  
  validates_presence_of :user_id, :content, :title, :flags, :rating => 0
  validates_numericality_of :user_id, :flags, :rating
  validates_length_of :title, :within => 20..100
  validates_length_of :content, :minimum => 15
  validates_inclusion_of :flags, :in => [ 1, 2 ] # 1 => false, 2 => true
  
  def self.change_rating( question_id, user_id, rating )
    puts "Rating : #{rating}"
    question = Question.where("id = ?",question_id).first
    if !question.nil?
       question.rating = question.rating + Integer(rating)
       if question.save
          return [1, question.rating, "Question Saved"]
       else
          return [-1, question.rating, "Question is not saved."]
       end
    else
       return [-1, "0", "Question Does Not Exist"]
    end
  end
  
  def follow_question(user_id)
    begin
      follow_question = UserQuestions.where("user_id = ? AND question_id = ?",user_id,self.id).first
      if follow_question.nil?
        UserQuestions.create!({
          :user_id => user_id,
          :question_id => self.id,
          :follow => true,
          :rating => 0,
          :flagged => 1
        });
      else
        if follow_question.follow.nil?
           follow_question.follow = true
        else
           follow_question.follow = !follow_question.follow
        end
        follow_question.save!
      end
    rescue
      return [ -1, "There is an error while following this question, Please try again later."]
    end
  end
  
  searchable do
    text :title, :default_boost => 2
    integer :rating
    text :content
  end
  handle_asynchronously :solr_index
end
