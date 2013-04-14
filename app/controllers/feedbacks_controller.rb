class FeedbacksController < ApplicationController
  def index
    if user_signed_in? && current_user.user_type == 1
      @feedbacks = Feedback.order("created_at desc")
    else
      redirect_to home_path
    end
  end
  
  def create
    if current_user.nil?
      user_id = 0
    else
      user_id = current_user.id
    end
    @feedback = Feedback.new(:content => params["feedback_content"], :rating => params["rating"], :user_id => user_id)
    @feedback.rating = 0 if @feedback.rating == nil
    @feedback.save!
      puts "feedback saved"
       respond_to do|format|
         format.js
       end
  end
end
