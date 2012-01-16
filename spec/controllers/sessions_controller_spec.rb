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

  describe"POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = {:NIP => "11111111", :password => "invalid"}
      end
      it "should re-ender the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content =>"Sign in")
      end
      
      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end
    
    describe "with valid NIP and password" do
      before(:each) do
        @lecture = Factory(:lecture)
        @attr = {:NIP => @lecture.NIP , :password => @lecture.password }
      end
      
      it "should sign in the user in" do
        post :create, :session => @attr
      end
      
      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(lecture_path(@lecture))
      end
    end
  end
end
