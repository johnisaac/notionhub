require 'spec_helper'

describe UserQuestions do
  before(:each) do
    @mock_user_question = {
      :user_id => 1,
      :question_id => 1,
      :flagged => 1,
      :rating => 1,
      :follow => false
    }
  end
  
  it "should have a user_id, question_id, flagged, rating" do
    user_question = UserQuestions.new(@mock_user_question.merge(:user_id => nil,:question_id => nil, :flagged => nil, :rating => nil))
    user_question.should_not be_valid
  end
  
  it "should have a user_id" do
    user_question = UserQuestions.new(@mock_user_question.merge(:user_id => nil))
    user_question.should_not be_valid
  end
  
  it "should have a question_id" do
    user_question = UserQuestions.new(@mock_user_question.merge(:question_id => nil))
    user_question.should_not be_valid
  end
  
  it "should have a flagged" do
    user_question = UserQuestions.new(@mock_user_question.merge(:flagged => nil))
    user_question.should_not be_valid
  end
  
  it "should have a rating" do
    user_question = UserQuestions.new(@mock_user_question.merge(:rating => nil))
    user_question.should_not be_valid
  end
  
  it "should have a numeric user_id" do
    user_question = UserQuestions.new(@mock_user_question.merge(:user_id => "nil"))
    user_question.should_not be_valid
  end
  
  it "should have a numeric question_id" do
    user_question = UserQuestions.new(@mock_user_question.merge(:question_id => "nil"))
    user_question.should_not be_valid
  end
  
  it "should have a numeric flagged" do
    user_question = UserQuestions.new(@mock_user_question.merge(:flagged => "sdsds"))
    user_question.should_not be_valid
  end
  
  it "should have a numeric rating" do
    user_question = UserQuestions.new(@mock_user_question.merge(:rating => "nil"))
    user_question.should_not be_valid
  end
  
  it "should have a rating with 1" do
    user_question = UserQuestions.new(@mock_user_question.merge(:rating => 2))
    user_question.should_not be_valid
  end
  
  it "should have a rating with -1" do
    user_question = UserQuestions.new(@mock_user_question.merge(:rating => -2))
    user_question.should_not be_valid
  end
  
  it "should have a unique [ question_id, user_id ]" do
      user_question = UserQuestions.new(@mock_user_question.merge(:question_id => 2, :user_id => 1))
      duplicate_rating =  UserQuestions.new(@mock_user_question.merge(:question_id => 2, :user_id => 1))
      duplicate_rating.should_not be_valid
  end
  
  it "should create a user_question with valid values" do
    user_question = UserQuestions.new(@mock_user_question)
    user_question.should be_valid
  end
  
  it "should create a user question when follow_question is invoked" do
    user_question = UserQuestions.new(@mock_user_question.merge(:follow => true))
    user_question.should be_valid
  end
end
