class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :a_comments, :dependent => :destroy
  has_many :user_answers
  
  before_create do |answer| 
     answer.rating = 0
  end
  
  after_create :send_participant_email
  
  validates_presence_of :content, :user_id, :question_id, :rating
  validates_numericality_of :user_id, :question_id, :rating
  validates_length_of :content, :minimum => 15
  
  
  def self.change_rating( answer_id, user_id, rating )
    answer = Answer.where("id = ?",answer_id).first
    if !answer.nil?
       puts "Answer: #{answer.inspect}"
       answer.rating = answer.rating + Integer(rating)
       if answer.save
          return [1, answer.rating, "Answer Saved"]
       else
          return [-1, answer.rating, "Answer is not saved."]
       end
    else
       return [-1, "0", "Answer Does Not Exist"]
    end
  end
  
  private
  def send_participant_email
    q_owner = User.select("u.email, u.name, u.id, q.title").where("q.id = ?",self.question_id).joins(" as u left join questions as q on u.id = q.user_id").first
    Reminder.new_answer(q_owner.email, self.question_id, q_owner.title, self.content).deliver!
    
    answerers = User.select("u.email, u.id").where("a.question_id = ? ", self.question_id).joins(" as u left join answers as a on a.user_id = u.id")
    answerers.each do|answer|
      if answer.email != q_owner.email
         Reminder.new_answer(answer.email, self.question_id, q_owner.title, self.content).deliver!
      end
    end
    
    followers = User.select("u.email,u.id").where("u_q.question_id = ? AND follow = ? ",self.question_id, true).joins(" as u left join user_questions as u_q on u.id = u_q.user_id ")
    followers.each do|follower|
      if follower.email != q_owner.email
         Reminder.new_answer(follower.email, self.question_id, q_owner.title, self.content).deliver!
      end
    end
    
  end
  
  searchable do
    text :content
    integer :rating
  end
  handle_asynchronously :solr_index
end
