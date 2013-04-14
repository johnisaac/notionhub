require 'spec_helper'

describe ContactPerson do
  describe "Invalid Cases" do
    before(:each) do
      @mock_contact = {
        :contact_name => "Mock Name",
        :contact_email => "mockname@gmail.com",
        :contact_phone => 944444444,
        :app_id => 1 
      }
    end
    
    
    it "should have all the mandatory fields" do
      @cp = ContactPerson.new
      @cp.should_not be_valid
    end
    
    it "should have a contact name" do
      @cp = ContactPerson.new(@mock_contact.merge(:contact_name => nil))
      @cp.should_not be_valid
    end
    
    it "should have a app_id" do
      @cp = ContactPerson.new(@mock_contact.merge(:app_id => nil))
      @cp.should_not be_valid
    end
    
    it "should have a numeric app_id" do
      @cp = ContactPerson.new(@mock_contact.merge(:app_id => "nil"))
      @cp.should_not be_valid
    end
    
    it "should  have a numeric contact phone" do
      @cp = ContactPerson.new(@mock_contact.merge(:contact_phone => "numeric"))
      @cp.should_not be_valid
    end
    
    it "should have a valid contact email" do 
      @cp = ContactPerson.new(@mock_contact.merge(:contact_email => "asdbajdbas"))
      @cp.should_not be_valid
    end
  end
  
  describe "Invalid Cases" do
    before(:each) do
      @mock_contact = {
        :contact_name => "Mock Name",
        :contact_email => "mockname@gmail.com",
        :contact_phone => 944444444,
        :app_id => 1 
      }
    end
    
    it "should create a contact person with all valid values" do
      @cp = ContactPerson.new(@mock_contact)
      @cp.should be_valid
    end
    
    it "should create a contact person with a blank email" do
      @cp = ContactPerson.new(@mock_contact.merge(:contact_email => ""))
      @cp.should be_valid
    end
    
    
    it "should create a contact person with a blank phone" do
      @cp = ContactPerson.new(@mock_contact.merge(:contact_phone => 0))
      @cp.should be_valid
    end
    
    
    it "should create a contact person with a blank email and blank phone" do
      @cp = ContactPerson.new(@mock_contact.merge(:contact_email => "",:contact_phone => 0))
      @cp.should be_valid
    end
  end
end
