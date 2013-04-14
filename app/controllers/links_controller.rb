class LinksController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit]
  
  def index
    @links = Link.where("flags = ?",1).order("created_at desc").limit(50)
  end
  
  def new 
    @link = Link.new
    respond_to do|format|
      format.html
    end
  end
  
  def show
      @link = Link.find(params[:id])
      if user_signed_in?
         @flagged = UserLinks.where("link_id = ? AND user_id = ?",params[:id],current_user.id).first
         puts "flagged: #{@flagged}"
      else
         @flagged = false
      end
      if @link.nil?
        redirect_to links_path
      end
  end
  
  def create
    if user_signed_in?
      @link = Link.new(params["link"])
      @link.user_id = current_user.id
      
      if @link.save
        redirect_to links_path
      else
        flash[:notice] = "Your link seems to be a invalid one"
        render new_link_path
      end
    else
      redirect_to links_path
    end
  end
  
  def post_comment
    @lcomment = LComment.new
    @lcomment.user_id = current_user.id
    @lcomment.content = params["content"]
    @lcomment.link_id = params["link_id"]
    
    if @lcomment.save
      respond_to do|format|
        format.js
      end
    else
      respond_to do|format|
        format.js
      end
    end
  end
  
  def destroy
    @link = Link.find(params["id"])
    Link.delete(@link)
    respond_to do|format|
      format.js
    end
  end
  
  def update
    @link = Link.find(params["id"])
    @link.title = params["title"]
    @link.URL = params["URL"]
    @name = User.find(current_user.id).name
    puts params.inspect
    if @link.save
      puts "Link Saved"
      respond_to do|format|
        format.js
      end
    else
      puts "Error"
    end
  end
  
  def set_flag
     @link = Link.where("id = ?",params["link_id"]).first
     @userlink = UserLinks.where("link_id = ? AND user_id = ?",params["link_id"],current_user.id).first

     if @userlink.nil?
       q_flag = UserLinks.new
       q_flag.user_id = current_user.id
       q_flag.link_id = params["link_id"]
       q_flag.flagged = params["flagged"]
       q_flag.flagged_time = Time.now
       q_flag.rating = 0
       q_flag.save!
       q_flag.flag_link
     else
       @userlink.flagged = params["flagged"]
       @userlink.flagged_time = Time.now
       @userlink.save!
       @userlink.flag_link
     end
     
    @remaining = 10-Integer(UserLinks.where("link_id = ?",params["link_id"]).count)
    respond_to do|format|
      format.js
    end
  end
  
  def get_links
    if user_signed_in?
      @links = Link.where(["user_id = ?",current_user.id]).order("created_at desc")
      puts @links.inspect
      respond_to do|format|
        format.js
      end
    else
      redirect_to home_path
    end
  end
  
  
  def top_links
    @links = Link.where("flags = ? AND created_at > ? AND rating > 0",1,Time.now-24.hours).order("rating desc").limit(50)
    puts @links.inspect
    respond_to do|format|
      format.js
    end
  end
  
  def load_related_stuff
    search = params["title"]
    @link_id = params["id"].strip

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
  
  
  def l_increase_rating 
    if user_signed_in?
      @result = UserLinks.increase_rating(params["link_id"], current_user.id)
      puts @result.inspect
    else
      puts @result.inspect
    end
    respond_to do|format|
      format.js
    end
  end
  
  def l_decrease_rating
    if user_signed_in?
      @result = UserLinks.decrease_rating( params["link_id"], current_user.id)
      puts @result.inspect
    else
      puts @result.inspect
    end
    respond_to do|format|
      format.js
    end
  end
  
end
