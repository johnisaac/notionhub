class AppsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @app = App.new
  
    respond_to do |format|
      format.html 
      format.xml { render :xml => @app }
    end
  end

  def create
      @app = App.new(params[:app])
      respond_to do |format|
        if @app.save!
          format.html { redirect_to(@app, :notice => 'User was successfully created.') }
          format.xml { render :xml => @app, :status => :created, :location => @app }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @app.errors, :status => :unprocessable_entity }
        end
      end
  end
  
  def edit
    begin
      @app = App.find(params[:id])
      if @app.nil? || current_user.id != @app.user_id
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

  def update
    begin
      @app = App.find(params[:id])
      respond_to do |format|
        if @app.update_attributes(params[:app])
          format.html { redirect_to(@app, :notice => 'App was successfully updated.') }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml { render :xml => @app.errors, :status => :unprocessable_entity }
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
    
      @app = App.find(params[:id])
      @updates = Update.where(:app_id => @app.id).order("created_at desc")
    
      if @app.nil? || current_user.id != @app.user_id
        redirect_to home_path
      else
        respond_to do |format|
          format.html # show.html.erb
          format.xml { render :xml => @app }
        end
      end

  end

  def index
    if user_signed_in?
      @apps = App.find(:all, :conditions => ["user_id = ?",current_user.id])
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    begin
      @app = App.find(params[:id])
      if !@app.nil? && current_user.id == @app.user_id
         App.destroy(@app.id)
         respond_to do |format|
           format.html { redirect_to(:action => "index") }
           format.xml  { head :ok }
         end 
      else
         redirect_to app_path(@app)
      end
    rescue
      if user_signed_in?
         redirect_to home_path
      else
         redirect_to new_user_session_path
      end
    end
  end
  
  def new_update
    @update = Update.new
    @update.content = params["content"]
    @update.app_id = params["app_id"]
    
    if @update.save
      respond_to do|format|
        format.js
      end
    else
      #send error message back to the front end
    end
  end
  
  def get_apps
    if user_signed_in?
      @apps = App.where(["user_id = ?",current_user.id]).order("created_at desc")
      respond_to do|format|
        format.js
      end
    else
      redirect_to home_path
    end
  end
end
