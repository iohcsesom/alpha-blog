class SessionsController < ApplicationController
  def new

  end

  def create
    currentUser = User.find_by(email: params[:session][:email].downcase)
    if currentUser && currentUser.authenticate(params[:session][:password])
      session[:user_id] = currentUser.id
      flash[:notice] = "Logged in successfully"
      redirect_to currentUser
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
