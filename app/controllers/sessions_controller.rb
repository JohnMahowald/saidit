class SessionsController < ApplicationController
  
  before_action :ensure_logged_in, except: [:create, :new]
  
  def create
    @user = User.find_by_credentials(
      user_params[:username], 
      user_params[:password]
    )
    
    if @user.nil?
      flash.now[:errors] = ["Invalid login credentials. Please try again"]
      render :new
    else
      flash[:notice] = ["Congrats. You remember your login!"]
      login_user!(@user)
      redirect_to user_url(@user)
    end
  end
  
  def destroy
    logout_user!
    redirect_to new_session_url
  end
  
  def new
    @user = User.new
    render :new
  end
end