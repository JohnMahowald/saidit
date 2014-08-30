class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method(
    :current_user, 
    :logged_in?
  )
  
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end
  
  def ensure_logged_in
    unless logged_in?
      flash[:errors] = ["You must be logged in to perform that action."]
      redirect_to new_session_url 
    end
  end
  
  def login_user!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end
  
  def logout_user!
    current_user.reset_session_token!
    session[:token] = nil
  end
  
  def logged_in?
    !!current_user
  end
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end