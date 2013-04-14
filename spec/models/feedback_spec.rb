require 'spec_helper'

describe Feedback do
  describe "Invalid Cases" do
    before(:each) do
      @mock_feedback = {
        :content => "Mock Feedback",
        :user_id => 1,
        :rating => 2
      }
    end
    
    it "should have a numeric rating" do
      feedback = Feedback.new(@mock_feedback.merge(:rating => "rating"))
      feedback.should_not be_valid
    end
    
    it "should have a numeric user_id" do
      feedback = Feedback.new(@mock_feedback.merge(:user_id => "user_id"))
      feedback.should_not be_valid
    end
    
    it "should have either content or rating" do
      feedback = Feedback.new(@mock_feedback.merge(:content => "", :rating => nil))
      feedback.should_not be_valid
    end
    
    it "should have either content or rating with a numeric user_id" do
      feedback = Feedback.new(@mock_feedback.merge(:content => "", :rating => 2, :user_id => "user_id"))
      feedback.should_not be_valid
    end

    it "should have a valid rating value" do
      feedback = Feedback.new(@mock_feedback.merge(:rating => 5))
      feedback.should_not be_valid
    end
  end
  
  
  describe "Valid Cases" do
    before(:each) do
      @mock_feedback = {
        :content => "Mock Feedback",
        :user_id => 1,
        :rating => 2
      }
    end
    
    it "should have create a feedback if content is not present but rating is present" do
      feedback = Feedback.new(@mock_feedback.merge(:content => "", :rating => 2))
      feedback.should be_valid
    end
    
    it "should have create a feedback if rating is not present but content is present" do
      feedback = Feedback.new(@mock_feedback.merge(:rating => 0))
      feedback.should be_valid
    end
  end
  
end
