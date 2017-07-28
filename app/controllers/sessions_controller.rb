class SessionsController < ApplicationController

  def new
    #form to login
    if logged_in?
      flash[:warn] = "You are already logged in"
      redirect_to root_path
    end
  end

  def create
    #login
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      flash[:sucess] = "You have successufully logged in"
      redirect_to chef
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    #logout
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
