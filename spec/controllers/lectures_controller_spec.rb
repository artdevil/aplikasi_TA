require 'spec_helper'

describe LecturesController do
  render_views
  describe "GET 'new'" do
    
    it "should be success" do
      get 'new'
      response.should be_success
    end
  end
end
