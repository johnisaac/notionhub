require 'spec_helper'

describe TopicQuestion do
  describe "Invalid Cases" do
    before(:each) do
      @tq_assoc = {
        :topic_id => 1,
        :question_id => 1
      }
    end
    
    it "should have a valid topic id" do
      tq_assoc = TopicQuestion.new(@tq_assoc.merge(:topic_id => nil))
      tq_assoc.should_not be_valid
    end
    
    it "should have a numeric topic id" do
      tq_assoc = TopicQuestion.new(@tq_assoc.merge(:topic_id => "nil"))
      tq_assoc.should_not be_valid
    end
    
    it "should have a valid question id" do
      tq_assoc = TopicQuestion.new(@tq_assoc.merge(:question_id => nil))
      tq_assoc.should_not be_valid
    end
    
    it "should have a numeric question id" do
      tq_assoc = TopicQuestion.new(@tq_assoc.merge(:topic_id => "nil"))
      tq_assoc.should_not be_valid
    end
  end
  
  describe "Valid Cases" do
    before(:each) do
      @tq_assoc = {
        :topic_id => 1,
        :question_id => 1
      }
    end
    
    it "should create a valid record with topic id and question id" do
      tq_assoc = TopicQuestion.new(@tq_assoc)
      tq_assoc.should be_valid
    end
  end
end
