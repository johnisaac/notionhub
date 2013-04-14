require 'spec_helper'

describe Authentication do
  before(:each) do
    @auth = {
      :user_id => 123,
      :provider => "facebook",
      :uid => "1312313"
    }
  end
  
  it "should have all the three fields" do
    user = Authentication.new
    user.should_not be_valid
  end
  
  it "should have a numeric user_id" do
    user = Authentication.new(@auth.merge(:user_id => "asdadsa"))
    user.should_not be_valid
  end
  
  it "should have a 'facebook' provider" do
    user = Authentication.new(@auth.merge(:provider => "asdadsa"))
    user.should_not be_valid
  end
  
end
