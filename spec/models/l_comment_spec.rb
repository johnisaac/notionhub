require 'spec_helper'

describe LComment do
  before(:each) do
    @mock_comment = {
      :user_id => 1,
      :link_id => 1,
      :content => "Mock Comment"
    }
  end
  
  describe "Invalid Cases" do
    it "should have a user_id" do
      @comment = LComment.new(@mock_comment.merge(:user_id => nil))
      @comment.should_not be_valid
    end
    
    it "should have a link_id" do
      @comment = LComment.new(@mock_comment.merge(:link_id => nil))
      @comment.should_not be_valid
    end
    
    it "should have a content" do
      @comment = LComment.new(@mock_comment.merge(:content => nil))
      @comment.should_not be_valid
    end
    
    it "should have a numeric user_id" do
      @comment = LComment.new(@mock_comment.merge(:user_id => "nil"))
      @comment.should_not be_valid
    end
    
    it "should have a numeric link_id" do
      @comment = LComment.new(@mock_comment.merge(:link_id => "nil"))
      @comment.should_not be_valid
    end
    
    it "should have a content greater than 5 characters" do
      @comment = LComment.new(@mock_comment.merge(:content => "nil"))
      @comment.should_not be_valid
    end
  end
  
  describe "Valid Cases" do
    it "should create a comment with valid values" do
        @comment = LComment.new(@mock_comment)
        @comment.should be_valid
    end
  end
end
