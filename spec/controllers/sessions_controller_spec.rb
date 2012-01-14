require 'spec_helper'

describe SessionsController do
  render_views
  describe "GET 'new'" do
    
    it "should be success" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign in | Aplikasi TA/PA IT Telkom")
    end
  end

end
