require 'spec_helper'

describe UserAnswers do
  before(:each) do
    @mock_user_answer = {
      :answer_id => 1,
      :user_id => 1,
      :rating => 1
    }
  end
  
  it "should have a answer_id, user_id, rating" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:answer_id => nil, :user_id => nil, :rating => nil))
    user_answer.should_not be_valid
  end
  
  it "should have a answer_id" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:answer_id => nil))
    user_answer.should_not be_valid
  end
  
  it "should have a user_id" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:user_id => nil))
    user_answer.should_not be_valid
  end
  
  it "should have a  rating" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:rating => nil))
    user_answer.should_not be_valid
  end
  
  it "should have a numeric answer_id" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:answer_id => "nil"))
    user_answer.should_not be_valid
  end
  
  it "should have a numeric user_id" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:user_id => "nil"))
    user_answer.should_not be_valid
  end
  
  it "should have a numeric rating" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:rating => "nil"))
    user_answer.should_not be_valid
  end
  
  it "should have a positive rating other than 1" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:rating => 2))
    user_answer.should_not be_valid
  end
  
  it "should have a negative rating other than -1" do
    user_answer = UserAnswers.new(@mock_user_answer.merge(:rating => -2))
    user_answer.should_not be_valid
  end
  
  it "should create a user_answer with valid values" do
    user_answer = UserAnswers.new(@mock_user_answer)
    user_answer.should be_valid
  end
end
