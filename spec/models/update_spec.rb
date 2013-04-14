require 'spec_helper'

describe Update do
  describe "Invalid Cases" do
    before(:each) do
      @mock_update = {
        :content => "Mock Update Content",
        :app_id => 1
      }
    end
    
    it "should have a content" do
      @update = Update.new(@mock_update.merge(:content => nil))
      @update.should_not be_valid
    end
    
    it "should have a app_id" do
      @update = Update.new(@mock_update.merge(:app_id => nil))
      @update.should_not be_valid
    end
    
    it "should have a nuermic app_id" do
      @update = Update.new(@mock_update.merge(:app_id => "nil"))
      @update.should_not be_valid
    end
    
    it "should have a content less than 140 chars" do
      @update = Update.new(@mock_update.merge(:app_id => "n"*141))
      @update.should_not be_valid
    end
  end
  
  describe "Valid Cases" do
    before(:each) do
      @mock_update = {
        :content => "Mock Update Content",
        :app_id => 1
      }
    end
    
    it "should create a update with valid values" do
      @update = Update.new(@mock_update)
      @update.should be_valid
    end
  end
end
