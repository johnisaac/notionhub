class QuestionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :follow]
  uses_tiny_mce 
  
  def new
    @question = Question.new
    respond_to do|format|
      format.html
    end
  end

  
  def create
    begin
      @question = Question.new(params[:question])
      respond_to do |format|
        if @question.save
          format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
          format.xml { render :xml => @question, :status => :created, :location => @question }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @question.errors, :status => :unprocessable_entity }
        end
      end
    rescue
      render new_question_path
    end
  end
  
  def edit
    begin
      @question = Question.find(params[:id])
      if @question.nil? || current_user.id != @question.user_id
        redirect_to home_path
      end
    rescue
      if user_signed_in?
         redirect_to home_path
      else
         redirect_to new_user_session_path
      end
    end
  end

  def destroy
    puts "Question Destroy Method........"
    @question = Question.find(params["id"])
    if Question.delete(@question)
      redirect_to questions_path
    else
      redirect_to question_path(@question)
    end
  end
  
  def update
    begin
      @question = Question.find(params[:id])
      respond_to do |format|
        if @question.update_attributes(params[:question])
          format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml { render :xml => @question.errors, :status => :unprocessable_entity }
        end
      end
    rescue
      if user_signed_in?
         redirect_to home_path
      else
         redirect_to new_user_session_path
      end
    end
  end
  
  def show
      @question = Question.find(params[:id])
      response.headers['Expires'] = "#{7.days.from_now}"
       
      @already_answered = false
      
      if user_signed_in?
         @flagged = UserQuestions.where("question_id = ? AND user_id = ?",params[:id],current_user.id).first
         puts "flagged: #{@flagged}"
      else
         @flagged = false
      end
      
      if @question.nil?
        redirect_to home_path
      else
        respond_to do |format|
          format.html # show.html.erb
          format.xml { render :xml => @question }
        end
      end
  end

  def index
      @questions = Question.where("flags = ?",1).order("created_at desc").limit(50)
      expires = 7.days.from_now
      response.headers['Expires'] = "#{7.days.from_now}"
  end
  
  def post_answer
    if user_signed_in?
      @answer = Answer.new
      @answer.content = params["answer"]
      @answer.question_id = params["question_id"]
      @answer.user_id = current_user.id
      @answer.rating = 0
      @name = User.find(current_user.id).name
       puts @answer.inspect
      if @answer.save
        @answers_count = "#{Question.find_by_id(params["question_id"]).answers.count}"
        
         respond_to do|format|
           format.js
         end
      else
         respond_to do |format|
           format.js 
         end
      end
    else
      redirect_to question_path(params["question_id"])
    end
  end
  
  def update_answer
    if user_signed_in?
      @answer = Answer.find(params["answer_id"])
      @name = User.find(current_user.id).name

      if @answer.update_attributes(:content => params["answer"])
        @answers_count = "#{Question.find_by_id(params["question_id"]).answers.count}"
        respond_to do|format|   
          format.js
        end
      else
        respond_to do|format|
          format.js
        end
      end
    else
      redirect_to question_path(params["question_id"])
    end
  end
  
  def delete_answer
    if user_signed_in?
      @answer = Answer.find(params["answer_id"])
      
      if !@answer.nil? && @answer.user_id == current_user.id
        puts "Answer is Not Null"
        Answer.delete(@answer)
        @answers_count = "#{Question.find_by_id(@answer.question_id).answers.count}"
        respond_to do|format|
          format.js
        end
      else
        puts "Answer is Null"
        respond_to do|format|
          format.js
        end
      end
    else
      redirect_to question_path(params["question_id"])
    end
  end

  def add_comment
    if user_signed_in?
      @comment = AComment.new
      @comment.user_id = current_user.id
      @comment.content = params["content"]
      @comment.answer_id = params["answer_id"]
      @name = User.find(current_user.id).name

      if @comment.save
        @answer_comment_count = AComment.where(["answer_id = ?",params["answer_id"]]).count
        puts @answer_comment_count
        puts "Saved"
        respond_to do|format|
          format.js
        end
      else
        @answer_comment_count = AComment.where(["answer_id = ?",params["answer_id"]]).count
        puts @answer_comment_count
        puts "Error"
        respond_to do|format|
          format.js
        end
      end

    else
      redirect_to question_path(params["question_id"])
    end
  end
  
  def delete_comment
    if user_signed_in?
     @comment = Comment.find(params["id"])
     
     if !@comment.nil? && @comment.user_id == current_user.id
       AComment.delete(@comment)
       respond_to do|format|
         format.js
       end
     else
       respond_to do|format|
         format.js
       end
     end
   else
     redirect_to question_path(params["question_id"])
   end
  end
  
  def get_questions
    if user_signed_in?
      @questions = Question.where(["user_id = ?",current_user.id]).order("created_at desc")
      respond_to do|format|
        format.js
      end
    else
      redirect_to home_path
    end
  end
  
  def top_questions
    @questions = Question.where("flags = ? AND updated_at > ? AND rating > 0",1,Time.now-24.hours).order("rating desc").limit(50)
    respond_to do|format|
      format.js
    end
  end
  
  
  def open_question
    @questions = Question.select("q.title, q.rating, q.id, q.content, q.updated_at, q.user_id").where("q.flags = 1 AND ans.question_id IS NULL").joins("as q left join answers as ans on q.id = ans.question_id").order("q.created_at desc").limit(50)
    respond_to do|format|
      format.js
    end
  end
  
  def set_flag
    # Check whether the user has a record in the UserQuestions
    # if he has a record, retrieve it and 
    @question = Question.where("id = ?",params["question_id"]).first
    @userquestion = UserQuestions.where("question_id = ? AND user_id = ?",params["question_id"],current_user.id).first
    
    if @userquestion.nil?
      q_flag = UserQuestions.new
      q_flag.user_id = current_user.id
      q_flag.question_id = params["question_id"]
      q_flag.flagged = params["flagged"]
      q_flag.flagged_time = Time.now
      q_flag.rating = 0
      q_flag.save!
      q_flag.flag_question
    else
      @userquestion.flagged = params["flagged"]
      @userquestion.flagged_time = Time.now
      @userquestion.save!
      @userquestion.flag_question
    end
    
    @remaining = 10-Integer(UserQuestions.where("question_id = ?",params["question_id"]).count)
    respond_to do|format|
      format.js
    end
  end
  
  def load_related_stuff
    search = params["title"].strip
    @q_id = params["q_id"].strip
    
    @related_questions = Question.search(:include => [:answers]) do
      keywords search do
        fields :title, :content
        phrase_fields :title => 3.0
        minimum_match(1)
        phrase_slop(1)
      end
      
      paginate( :page => 1, :per_page => 7)
    end
    
    @related_links = Link.search(:include => [:l_comments]) do
       keywords search do
         fields :title 
         phrase_fields :title => 3.0
         minimum_match(1)
         phrase_slop(1)
       end

       paginate(:page => 1, :per_page => 7) 
     end
        
    respond_to do|format|
      format.js
    end
  end
  
  def q_increase_rating 
    if user_signed_in?
      @result = UserQuestions.increase_rating(params["question_id"], current_user.id)
      puts @result.inspect
    else
      puts @result.inspect
    end
    respond_to do|format|
      format.js
    end
  end
  
  def q_decrease_rating
    if user_signed_in?
      @result = UserQuestions.decrease_rating( params["question_id"], current_user.id)
      puts @result.inspect
    else
      puts @result.inspect
    end
    respond_to do|format|
      format.js
    end
  end
  
  def a_increase_rating 
    if user_signed_in?
      @result = UserAnswers.increase_rating(params["answer_id"], current_user.id)
      puts @result.inspect
    else
      puts @result.inspect
    end
    respond_to do|format|
      format.js
    end
  end
  
  def a_decrease_rating
    if user_signed_in?
      @result = UserAnswers.decrease_rating( params["answer_id"], current_user.id)
      puts @result.inspect
    else
      puts @result.inspect
    end
    respond_to do|format|
      format.js
    end
  end
  
  def follow
    if user_signed_in?
      @question = Question.find(params["question_id"])
      if !@question.nil?
        @question.follow_question(current_user.id)
      end
      @user_question = UserQuestions.where("question_id = ? AND user_id =?", params["question_id"], current_user.id).first
      puts @user_question.follow
    end
    respond_to do|format|
      format.js
    end
  end
end
