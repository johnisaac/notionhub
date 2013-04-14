class SearchController < ApplicationController
  def index
      puts params["query"]
    
      @questions_search = Question.search(:include => [ :answers ]) do
        keywords params["query"] do
          fields :title, :content
          phrase_fields :title => 3.0
          minimum_match(1)
          phrase_slop(1)
        end
        
        paginate(:page => 1, :per_page => 20)
      end
      
      @links_search = Link.search(:include => [ :l_comments ]) do
        keywords params["query"] do
          fields :title 
          phrase_fields :title => 3.0
          minimum_match(1)
          phrase_slop(1)
        end
        
        paginate(:page => 1, :per_page => 20)
      end
      @query = params["query"] if params["query"] != nil
  end
  
  def load_more_questions
    @more_questions = Question.search(:include => [:answers]) do
      keywords params["query"] do
        fields :title, :content
        phrase_fields :title => 3.0
        minimum_match(1)
        phrase_slop(1)
      end
      
      paginate( :page => params["next_q_page"], :per_page => 20)
    end
    
    if @more_questions.results.count > 0
       @next_q_page = Integer(params["next_q_page"])+1
    else
       @next_q_page = Integer(params["next_q_page"])
    end
    
    respond_to do|format|
      format.js
    end
  end
  
  def load_more_links
    @more_links = Link.search(:include => [:l_comments]) do
      keywords params["query"] do
        fields :title 
        phrase_fields :title => 3.0
        minimum_match(1)
        phrase_slop(1)
      end
      
      paginate( :page => params["next_l_page"], :per_page => 20)
    end

    if @more_links.results.count > 0
       @next_l_page = Integer(params["next_l_page"])+1
    else
       @next_l_page = Integer(params["next_l_page"])
    end
    
    respond_to do|format|
      format.js
    end
  end
end
