class SessionsController < ApplicationController
  skip_before_action :require_login
  
  def new
  end

  def create
    # if user logs in using social network
    if env["omniauth.auth"]
      # we update record in users oauth table
      user_oauth = UsersOauth.from_omniauth(env["omniauth.auth"])
      # then we lookup user using email
      user = User.find_by(email: user_oauth.email)
      # then we either have existing user
      if user
        sign_in user
        flash[:notice] = 'Welcome to the site'
        redirect_to welcome_path
      else
        user = User.from_omniauth(env["omniauth.auth"])
        sign_in user
        flash[:notice] = "Welcome to the site, we created new account for you based on information received from #{user_oauth.provider}"
        redirect_to welcome_path
      end
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        flash[:notice] = 'Welcome to the site'
        redirect_to welcome_path
      else
        flash[:error] = 'Invalid email/password combination'
        redirect_to signin_path
      end
    end
  end

  def reset_password
    render :reset_password
  end

  def process_reset_password
    user = User.find_by(email: params[:email].downcase)
    if user
      # generate reset token + its creation time
      user.generate_token(:password_reset_token)
      user.password_reset_sent_at = Time.zone.now
      # and save it
      user.save(:validate => false)
      # send an email
      UserMailer.password_reset(user).deliver
      # redirect back to login page
      flash[:notice] = "Email sent with password reset instructions."
      # render :text  => CGI.escapeHTML(user.inspect)
      redirect_to signin_path
    else
      flash[:warning] = "Something wrong with the email you have entered?"
      redirect_back_or root_path
    end
  end

  def reset_password_finish
      # if token is valid and did not expire yet render new password form
      @user = User.where(password_reset_token: params[:token]).first
      if @user
        render :new_password
      else
        # token is invalid
        flash[:error] = "Token is invalid, we are sorry. Please go again through password reset process"
        redirect_to signin_path
      end
  end

  def reset_password_finish_save
      # if token is valid and did not expire yet render new password form
      user = User.where(password_reset_token: params[:token]).first
      if user
        user.password = params[:new_password]
        user.password_confirmation = params[:new_password]
        # and we change the reset token to something unknown
        user.generate_token(:password_reset_token)
        user.save
        flash[:notice] = "Your password was changed, please log in and enjoy the site."
        redirect_to signin_path
      else
        # token is invalid
        flash[:error] = "Token is invalid, we are sorry. Please go again through password reset process"
        redirect_to signin_path
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