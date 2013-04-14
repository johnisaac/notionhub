require 'spec_helper'

describe TopicUser do
  before(:each) do
    @topic_user = {
      :user_id => 1,
      :topic_id => 1
    }
  end
  
  it "should have a user_id, topic_id" do
    topic_user = TopicUser.new(@topic_user.merge(:user_id => nil,:topic_id => nil))
    topic_user.should_not be_valid
  end
  
  it "should have a user_id" do
    topic_user = TopicUser.new(@topic_user.merge(:user_id => nil))
    topic_user.should_not be_valid
  end
  
  it "should have a numeric user_id" do
    topic_user = TopicUser.new(@topic_user.merge(:user_id => "nil"))
    topic_user.should_not be_valid
  end
  
  it "should have a numeric topic_id" do
    topic_user = TopicUser.new(@topic_user.merge(:topic_id => "nil"))
    topic_user.should_not be_valid
  end
  
  it "should have a unique [ topic_id, user_id ]"
  
  it "should create a topic_user with valid values" do
    topic_user = TopicUser.new(@topic_user)
    topic_user.should be_valid
  end

end
