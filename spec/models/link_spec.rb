require 'spec_helper'

describe Link do
  before(:each) do
    @mock_link = {
      :title => "Mock Link Title",
      :URL => "http://www.yahoo.com",
      :user_id => 1
    }
  end
  
  describe "Invalid Cases" do
    it "should have a title" do
      link = Link.new(@mock_link.merge(:title => nil))
      link.should_not be_valid
    end
    
    it "should have a URL" do
      link = Link.new(@mock_link.merge(:URL => nil))
      link.should_not be_valid
    end
    
    it "should have a user_id" do
      link = Link.new(@mock_link.merge(:user_id => nil))
      link.should_not be_valid
    end
    
    it "should have a title that is no less than 5 characters" do
      link = Link.new(@mock_link.merge(:URL => "nil1"))
      link.should_not be_valid
    end
    
    it "should have a valid URL" do
      link = Link.new(@mock_link.merge(:URL => "nil"))
      link.should_not be_valid
    end
    
    it "should have numeric user_id" do
      link = Link.new(@mock_link.merge(:user_id => "nil"))
      link.should_not be_valid
    end
  end
  
  
  describe "Valid Cases" do
    it "should create link without http" do
      link = Link.new(@mock_link.merge(:URL => "www.yahoo.com"))
      link.should be_valid
    end
    
    it "should create link without https" do
      link = Link.new(@mock_link.merge(:URL => "www.yahoo.com"))
      link.should be_valid
    end
    
    it "should create link without www"  do
      link = Link.new(@mock_link.merge(:URL => "http://yahoo.com"))
      link.should be_valid
    end
    
    it "should create link with www1" do
      link = Link.new(@mock_link.merge(:URL => "www1.yahoo.com"))
      link.should be_valid
    end
    
    it "should create link with www2" do
      link = Link.new(@mock_link.merge(:URL => "www2.yahoo.com"))
      link.should be_valid
    end
    
    it "should create link with http" do
      link = Link.new(@mock_link.merge(:URL => "http://www.yahoo.com"))
      link.should be_valid
    end
    
    it "should create link with https" do
      link = Link.new(@mock_link.merge(:URL => "https://www.yahoo.com"))
      link.should be_valid
    end
    
    it "should create link with a blogspot url" do
      link = Link.new(@mock_link.merge(:URL => "www.johnfelix.blogspot.com"))
      link.should be_valid
    end
    
    it "should create link with a tumblr url"  do
      link = Link.new(@mock_link.merge(:URL => "www.johnfelix.tumblr.com"))
      link.should be_valid
    end
    
    it "should create link with a posterous url"  do
      link = Link.new(@mock_link.merge(:URL => "www.john-felix.posterous.com"))
      link.should be_valid
    end
    
  end
end
