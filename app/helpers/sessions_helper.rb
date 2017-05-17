module SessionsHelper

  # Allows user to login
  def login(user)
    session[:user_id] = user.id
  end

  # Returns current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Check if user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Allows user to logout
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
