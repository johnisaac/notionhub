require 'rating_logic.rb'
class UserQuestions < ActiveRecord::Base
  extend RatingLogic
  
  belongs_to :user
  belongs_to :question

  
  validates_presence_of :user_id, :question_id, :flagged, :rating
  validates_numericality_of :user_id, :question_id, :flagged, :rating
  validates_inclusion_of :flagged, :in => [1,2] # 1 => false, 2 => true
  validates_inclusion_of :rating, :in =>[1, 0, -1]
  validates_uniqueness_of :question_id, :scope => [ :user_id ]

  
  def flag_question
    puts "flag_question"
    @question = Question.find(self.question_id)
    if @question.flagged_time.nil?
      flag_count = check_flag_count(nil) 
    else
      flag_count = check_flag_count(@question.flagged_time) 
    end
    puts "FLAG COUNT BEFORE-------------------#{flag_count}-------------------"   
    if flag_count!= 0 && flag_count%10 == 0
      if @question.flags == 1
         @question.flags = 2
         @question.flagged_time = Time.now
      else
         @question.flags = 1
         @question.flagged_time = Time.now
      end
      if @question.save
         puts "updated"
      else
         puts "not updated"
      end
    end
  end
  
  def check_flag_count(flagged_time)
    #get the count of the records which has the same number of flagged items,
    #which has happened greater than last flagged time of the question and with the same flag,
    # and for this question,s
    # return the count
    puts "Flagged time parameter:  #{flagged_time}"
    flag_count = UserQuestions.where("question_id = ? AND flagged_time > ? AND flagged = ?", self.question_id, flagged_time, self.flagged).count
    
    puts "Current Flag Count: #{flag_count}"
    return flag_count
  end
  
end
