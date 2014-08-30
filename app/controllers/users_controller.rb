class UsersController < ApplicationController
  
  before_action :ensure_logged_in, except: [:create, :new]
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = ["Welcome to Bluit"]
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
end