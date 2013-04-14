class ContactPersonsController < ApplicationController
  def create
    @contactperson = ContactPerson.new(params[:contact_person])
    if @contactperson.save!
       return 1
    else 
       return 0 
    end      
  end
end
