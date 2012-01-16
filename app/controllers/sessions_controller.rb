class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    lecture = Lecture.authenticate(params[:session][:NIP],params[:session][:password])
    if lecture.nil?
      flash.now[:error] = "invalid NIP/password combination"
      @title = "Sign in"
      render "new"  
    else
      sign_in lecture
      redirect_to lecture
    end
  end
  
  def destroy
    
  end
end
