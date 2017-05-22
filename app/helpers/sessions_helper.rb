module SessionsHelper

  # Allows user to login
  def login(user)
    session[:user_id] = user.id
  end
  
  # Persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # End persistent session
  def forget(user) 
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns if user is who they claim they are
  def current_user?(user)
    user == current_user
  end

  # Returns current user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  # Check if user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Allows user to logout
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
