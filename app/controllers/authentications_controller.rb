class AuthenticationsController < ApplicationController
  def index
    @authentication = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    
    if authentication
      sign_in_and_redirect( :user, authentication.user )
    elsif current_user
      current_user.authentications.create!(:provider => omniauth["provider"], :uid => omniauth["uid"])  
      redirect_to authentications_url
    else
      user = User.new
      user.name  = omniauth["user_info"]["name"] if omniauth["user_info"]["name"] != nil
      user.email = omniauth["extra"]["user_hash"]["email"] if omniauth["extra"]["user_hash"]["email"] != nil
      user.authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])
      begin
         user.save
         sign_in_and_redirect( :user, user )
         session[:omniauth] = nil
      rescue Exception => e
         puts e.inspect
         session[:errors] = "Email has already been taken."
         redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication =  Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Succesfully destroyed authentication."
    redirect_to authentications_url
  end

end
