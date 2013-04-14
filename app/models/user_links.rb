require 'rating_logic.rb'
class UserLinks < ActiveRecord::Base
  extend RatingLogic  
  belongs_to :user
  belongs_to :link
  
  validates_presence_of :user_id, :link_id, :flagged, :rating
  validates_numericality_of :user_id, :link_id, :flagged, :rating
  validates_inclusion_of :flagged, :in => [1,2] # 1 => false, 2 => true
  validates_uniqueness_of :link_id, :scope => [:user_id]
  validates_inclusion_of :rating, :in => [1,0,-1]
  
 
  
  
  def flag_link
    puts "flag_link"
    @link = Link.find(self.link_id)
    if @link.flagged_time.nil?
        flag_count = check_flag_count(0)
    else
        flag_count = check_flag_count(@link.flagged_time)
    end
    puts flag_count   
    
    if flag_count!= 0 && flag_count%10 == 0
      if @link.flags == 1
         @link.flags = 2
         @link.flagged_time = Time.now
      else
         @link.flags = 1
         @link.flagged_time = Time.now
      end
      if @link.save
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
    flag_count = UserLinks.where("link_id = ? AND flagged_time > ? AND flagged = ?", self.link_id, flagged_time, self.flagged).count
    
    puts "Current Flag Count: #{flag_count}"
    return flag_count
  end
end
