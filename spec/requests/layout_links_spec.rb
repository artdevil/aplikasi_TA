require 'spec_helper'

describe "LayoutLinks" do
  it "should have a login page at '/'" do
    get "/"
    response.should have_selector("title", :content => "Sign in")
  end
end
