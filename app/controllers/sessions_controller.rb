class SessionsController < ApplicationController
  skip_before_action :require_login
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
 	    sign_in user
 	    flash[:notice] = 'Welcome to the site'
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
		sign_out
		redirect_to root_path
  end

  def toggle_own
    if session[:own] 
      session[:own]=false
    else
      session[:own]=true
    end
    redirect_to root_path
  end

end