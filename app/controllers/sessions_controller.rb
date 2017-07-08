class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      else
        user.send_activation_email
        flash[:warning] = "Complete account activation using email link"
      end
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid email and/or invalid password"
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end

