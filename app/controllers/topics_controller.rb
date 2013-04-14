class TopicsController < ApplicationController
  def new
    @topic = Topic.new
    @topic.name = params[:name]
    if @topic.save!
      respond_to do|format|
        format.html
      end
    else
      render :edit
    end
  end

  def edit
  end

  def index
  end
  
  def show
    @topic = Topic.find(params[:id])
    if !@topic.nil?
      
      if user_signed_in?
        @topic_user = TopicUser.where("topic_id = ? AND user_id = ?",params[:id], current_user.id).first
      end
      
      @topic_questions = @topic.topic_questions
    
      respond_to do|format|
        format.html
      end
      
    else
      redirect_to root_path
    end
  end
  
  def add_topic_to_question
    if !params[:topic_id].nil? && !params[:question_id].nil?
      
      topic_question = TopicQuestion.new
      topic_question.topic_id = params[:topic_id]
      topic_question.question_id = params[:question_id]
      
      if topic_question.save!
        @saved = 1
      else
        @saved = 0
      end
    else
      @saved = -1
    end
    respond_to do|format|
      format.js
    end
  end
  
  def remove_topic_from_question
    if !params[:topic_id].nil? && !params[:question_id].nil?
      topic_question = TopicQuestion.where("topic_id = ? AND question_id = ?", params[:topic_id], params[:question_id]).first
      if !topic_question.nil?
        topic_question.destroy!
        @saved = 1
      else
        @saved = 0
      end
    else
      @saved = -1
    end
    respond_to do|format|
      format.js
    end
  end
  
  def unfollow_topic
    if user_signed_in? && !params[:topic_id].nil?
      topic = TopicUser.where("topic_id = ? AND user_id = ?",params[:topic_id], current_user.id).first
      if !topic.nil?
        topic.destroy
        @saved = 1
      else
        @saved = 0
      end
    else
      @saved = -1
    end
    respond_to do|format|
      format.js
    end
  end

  def follow_topic
    if user_signed_in? && !params[:topic_id].nil?
      topic_user = TopicUser.where("topic_id = ? AND user_id = ?",params[:topic_id], current_user.id).first
      
      if topic_user.nil?
        topic_user = TopicUser.new
        topic_user.user_id = current_user.id
        topic_user.topic_id = params[:topic_id]
        
        if topic_user.save!
          @saved = 1
        else
          @saved = 0
        end
        
      else
        puts "topic is already followed"
        @saved = 0
      end
    else
      @saved = -1
    end
    respond_to do|format|
      format.js
    end
  end
end
