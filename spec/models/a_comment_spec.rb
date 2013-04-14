require 'spec_helper'

describe AComment do
  before(:each) do
    @mock_comment = {
      :user_id => 1,
      :answer_id => 1,
      :content => "Mock Comment"
    }
  end
  
  describe "Invalid Cases" do
    it "should have a user_id" do
      @comment = AComment.new(@mock_comment.merge(:user_id => nil))
      @comment.should_not be_valid
    end
    
    it "should have a answer_id" do
      @comment = AComment.new(@mock_comment.merge(:answer_id => nil))
      @comment.should_not be_valid
    end
    
    it "should have a content" do
      @comment = AComment.new(@mock_comment.merge(:content => nil))
      @comment.should_not be_valid
    end
    
    it "should have a numeric user_id" do
      @comment = AComment.new(@mock_comment.merge(:user_id => "nil"))
      @comment.should_not be_valid
    end
    
    it "should have a numeric answer_id" do
      @comment = AComment.new(@mock_comment.merge(:answer_id => "nil"))
      @comment.should_not be_valid
    end
    
    it "should have a content greater than 1 character" do
      @comment = AComment.new(@mock_comment.merge(:content => ""))
      @comment.should_not be_valid
    end
  end
  
  describe "Valid Cases" do
    it "should create a comment with valid values" do
        @comment = AComment.new(@mock_comment)
        @comment.should be_valid
    end
  end
end
