require 'spec_helper'

describe Answer do
  before(:each) do
    @mock_answer = {
      :content => "Answer to the question",
      :user_id => 1,
      :question_id => 1,
      :rating => 1
    }
  end
  
  describe "Invalid Cases" do
    it "should have a content" do
      answer = Answer.new(@mock_answer.merge(:content => nil))
      answer.should_not be_valid
    end
    
    it "should have a user_id" do
      answer = Answer.new(@mock_answer.merge(:user_id => nil))
      answer.should_not be_valid
    end
    
    it "should have a question_id"do
      answer = Answer.new(@mock_answer.merge(:question_id => nil))
      answer.should_not be_valid
    end
    
    it "should have a rating" do
      answer = Answer.new(@mock_answer.merge(:rating => nil))
      answer.should_not be_valid
    end
    
    it "should have a content with more than 15 characters"do
      answer = Answer.new(@mock_answer.merge(:content => "n"*14))
      answer.should_not be_valid
    end
    
    it "should have a numeric user_id" do
      answer = Answer.new(@mock_answer.merge(:user_id => "nil"))
      answer.should_not be_valid
    end
    
    it "should have a numeric rating" do
      answer = Answer.new(@mock_answer.merge(:rating => "nil"))
      answer.should_not be_valid
    end
    
    it "should have a numeric question_id" do
      answer = Answer.new(@mock_answer.merge(:question_id => "nil"))
      answer.should_not be_valid
    end
    
  end
  
  describe "Valid Cases" do
    it "should create a valid answer"do
      answer = Answer.new(@mock_answer)
      answer.should be_valid
    end
  end
end
