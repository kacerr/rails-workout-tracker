module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end    

  def signed_in?
    !current_user.nil?
  end


  def sign_out
    if current_user
      current_user.update_attribute(:remember_token,
                                    User.encrypt(User.new_remember_token))
      cookies.delete(:remember_token)
      self.current_user = nil
    end
  end	

  def is_admin?
    current_user && current_user.isAdmin?
  end

  def own_only?
    session[:own]
  end

  def redirect_back_or(default)
    logger.debug(session[:return_to])
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def require_login
    redirect_to signin_path unless signed_in?
  end
end