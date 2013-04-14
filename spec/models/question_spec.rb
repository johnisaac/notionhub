require 'spec_helper'

describe Question do
  describe "Invalid Cases" do
    before(:each) do    
      @mock_question = {
        :user_id => 1,
        :content => "Content of the Question",
        :title => "Title of the Question",
        :flags => 1,
        :rating => 0
      }
    end
    
    it "should have a user_id" do
      question = Question.new(@mock_question.merge(:user_id => nil))
      question.should_not be_valid
    end
    
    it "should have a content" do
      question = Question.new(@mock_question.merge(:content => nil))
      question.should_not be_valid
    end
    
    it "should have a title" do
      question = Question.new(@mock_question.merge(:title => nil))
      question.should_not be_valid
    end
    
    it "should have a numeric user_id" do
      question = Question.new(@mock_question.merge(:user_id => "nil"))
      question.should_not be_valid
    end
    
    it "should have a numeric rating" do
      question = Question.new(@mock_question.merge(:user_id => "nil"))
      question.should_not be_valid
    end
    
    it "should have a content greater than 15 characters" do
      question = Question.new(@mock_question.merge(:content => "nil"))
      question.should_not be_valid
    end
    
    it "should not have a title greater than 100 characters" do
      question = Question.new(@mock_question.merge(:title => "a"*101))
      question.should_not be_valid
    end
    
    it "should not have a title lesser than 20 characters" do
      question = Question.new(@mock_question.merge(:title => "a"*19))
      question.should_not be_valid
    end
    
    it "should have a flag" do
      question = Question.new(@mock_question.merge(:title => "a"*26,:flags => nil))
      question.should_not be_valid
    end
    
    it "should have a numeric flag" do
      question = Question.new(@mock_question.merge(:title => "a"*26,:flags => "flag"))
      question.should_not be_valid
    end

  end
  
  describe "Valid Cases" do
    before(:each) do    
      @mock_question = {
        :user_id => 1,
        :content => "Content of the Question",
        :title => "Title of the Question",
        :flags => 1,
        :rating => 0
      }
    end
    it "should have a user_id, content, title" do
      question = Question.new(@mock_question.merge(:title => "a"*26,:flags => 1))
      puts question.inspect
      question.should be_valid
    end
  end
end
