class ContactusController < ApplicationController
  def new
  end

  def create
    @contactus = ContactUs.new
    @contactus.email = params["email"]
    puts "---------------------"
    puts params["email"]
    puts "---------------------"
    
    if @contactus.save
       redirect_to home_path
    else
       redirect_to contactus_path
    end
  end
  
  def index
  end

end
