require 'spec_helper'

describe UserLinks do
  before(:each) do
    @mock_user_link = {
      :user_id => 12222,
      :link_id => 1,
      :flagged => 1,
      :rating => 1
    }
  end
  
  it "should have a user_id, link_id, flagged" do
    user_link = UserLinks.new(@mock_user_link.merge(:user_id => nil,:link_id => nil, :flagged => nil))
    user_link.should_not be_valid
  end
  
  it "should have a user_id" do
    user_link = UserLinks.new(@mock_user_link.merge(:user_id => nil))
    user_link.should_not be_valid
  end
  
  it "should have a link_id" do
    user_link = UserLinks.new(@mock_user_link.merge(:link_id => nil))
    user_link.should_not be_valid
  end
  
  it "should have a flagged" do
    user_link = UserLinks.new(@mock_user_link.merge(:flagged => nil))
    user_link.should_not be_valid
  end
  
  it "should have a numeric user_id" do
    user_link = UserLinks.new(@mock_user_link.merge(:user_id => "nil"))
    user_link.should_not be_valid
  end
  
  it "should have a numeric link_id" do
    user_link = UserLinks.new(@mock_user_link.merge(:link_id => "nil"))
    user_link.should_not be_valid
  end
  
  it "should have a rating" do
    user_link = UserLinks.new(@mock_user_link.merge(:rating => nil))
    user_link.should_not be_valid
  end
  
  it "should have a numeric rating" do
    user_link = UserLinks.new(@mock_user_link.merge(:rating => "nil"))
    user_link.should_not be_valid
  end
  
  it "should have a valid rating" do
    user_link = UserLinks.new(@mock_user_link.merge(:rating => 1123))
    user_link.should_not be_valid
  end
  
  it "should have a numeric flagged" do
    user_link = UserLinks.new(@mock_user_link.merge(:flagged => "sdsds"))
    puts user_link.inspect
    user_link.should_not be_valid
  end
  
  it "should create a user_link with valid values" do
    user_link = UserLinks.new(@mock_user_link)
    user_link.should be_valid
  end
end
