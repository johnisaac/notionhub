require 'spec_helper'

describe Topic do
  describe "Invalid Cases" do
     it "should have a name" do
       @topic = Topic.new(:name => nil)
       @topic.should_not be_valid
     end
  end
  
  describe "Valid Cases" do
    it "should create a topic associated with a valid question" do
      @topic = Topic.new(:name=>"New Topic")
      @topic.should be_valid
    end
  end
end
