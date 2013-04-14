require 'spec_helper'

describe CompanyController do
  render_views
  describe "GET 'aboutus'" do
    it "should be successful" do
      get 'aboutus'
      response.should be_success
    end
  end

  describe "GET 'contactus'" do
    it "should be successful" do
      get 'contactus'
      response.should be_success
    end
  end

end
