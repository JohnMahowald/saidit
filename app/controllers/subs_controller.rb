class SubsController < ApplicationController
  
  before_action :ensure_logged_in, except: [:index, :show]
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash[:notice] = ["Sub created successfully."]
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    return unless @sub.is_moderator?(current_user)
    @sub.destroy
    flash[:notice] = ["FATAL: Sub has been Destroyed!"]
    redirect_to subs_url
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def update
    @sub = Sub.find(params[:id])
    if (@sub.is_moderator?(current_user)) && @sub.update_attributes(sub_params)
      flash[:notice] = ["Sub updated successfully."]
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end