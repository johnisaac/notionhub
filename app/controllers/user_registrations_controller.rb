class UserRegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => [ :destroy, :update, :edit ]
  
  def index
     if user_signed_in?
        redirect_to edit_user_registration_path(:id => current_user.id)
      else
        redirect_to new_user_session_path
      end
  end
  
  def create
    user = User.where("email = ?",params["user"]["email"].strip)
    if user.empty?
      super   
      session[:omniauth] = nil unless @user.new_record?
    else
      session[:errors] = "Email has already been taken."
      redirect_to new_user_registration_path 
    end
  end
  
  def facebook
  end
  
  def upload_photo
    if user_signed_in?
      @user = User.find(current_user.id)
      if !@user.nil?
        @user.update_attributes(params[:user])
      end
      redirect_to edit_user_registration_path(:id => current_user.id)
    else
      redirect_to new_user_session_path
    end
  end
  
  def show
      if !current_user.nil? && current_user.id == Integer(params[:id])
          redirect_to edit_user_registration_path(:id => current_user.id)
      else
         @user = User.find(params[:id])
         @questions = Question.where("user_id = ?",params[:id])
         @links = Link.where("user_id = ?",params[:id])
         @answers = Answer.where("user_id = ?", params[:id])
      end
  end
  
  def user_photo
    if user_signed_in?
      @photo = current_user.photo
      respond_to do|format|
        format.js
      end
    end
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def add_description
      @user = User.find(current_user.id)
      if !@user.nil?
        @user.description = params["description"]
        if @user.save
           respond_to do|format|
             format.js
           end
        end
      else
        respond_to do|format|
          format.js
        end
      end
  end
  
end
