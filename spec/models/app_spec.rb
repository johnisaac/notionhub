require 'spec_helper'

describe App do
  describe "Invalid Cases" do
    before(:each) do
      @mock_app = {
      :university => "sample university",
      :department => "computer science",
      :degree => 1,
      :status => 1,
      :deadline => "12/12/2010",
      :user_id => 1
    }
    end
    
    it "should have all the mandatory fields" do
      @app = App.new
      @app.should_not be_valid
    end
    
    it "should have a university name" do
      @app = App.new(@mock_app.merge(:university => ""))
      @app.should_not be_valid
    end
    
    it "should have a department name" do
      @app = App.new(@mock_app.merge(:department => ""))
      @app.should_not be_valid
    end
    
    it "should have a degree" do
      @app = App.new(@mock_app.merge(:degree => ""))
      @app.should_not be_valid
    end
    
    it "should have a status" do
      @app = App.new(@mock_app.merge(:status => nil))
      @app.should_not be_valid
    end
    
    it "should have a status" do
       @app = App.new(@mock_app.merge(:status => "nil"))
       @app.should_not be_valid
    end
     
    it "should have a valid status(1,2,3,4)" do
      @app = App.new(@mock_app.merge(:status => 5))
      @app.should_not be_valid
    end
    
    it "should have a valid degree(1,2,3)" do
      @app = App.new(@mock_app.merge(:degree => 5))
      @app.should_not be_valid
    end
    
    it "should have a numeric degree" do
      @app = App.new(@mock_app.merge(:degree => "degree"))
      @app.should_not be_valid
    end
    
    it "should have a valid deadline with a future date" do
      @app = App.new(@mock_app.merge(:deadline =>"12/12/2008"))
      @app.should_not be_valid
    end
    
    it "should have a user_id" do
      @app = App.new(@mock_app.merge(:user_id => nil))
      @app.should_not be_valid
    end
    
    it "should have an integer user_id" do
      @app = App.new(@mock_app.merge(:user_id => "nil"))
      @app.should_not be_valid
    end
    
    it "should have a university name greater than 5 characters" do
      @app = App.new(@mock_app.merge(:university => "MSU"))
      @app.should_not be_valid
    end
    
    it "should have a department value greater than 5 characters" do
      @app = App.new(@mock_app.merge(:department => "CSE"))
      @app.should_not be_valid
    end
  end
  
  describe "Valid Cases" do
    before(:each) do
      @mock_app = {
      :university => "sample university",
      :department => "computer science",
      :degree => 1,
      :status => 1,
      :deadline => "12/12/2010",
      :user_id => 1
    }
    end
    
    it "should create a application with valid values" do
      @app = App.new(@mock_app)
      @app.should be_valid
    end
    
  end
end
