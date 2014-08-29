class PostsController < ApplicationController
  
  before_action :ensure_logged_in, except: [:show]
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:notice] = ["Post created successfully."]
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    return unless @post.is_author?(current_user)
    sub_id = @post.sub_id
    @post.destroy
    flash[:notice] = ["FATAL: Post has been Destroyed!"]
    redirect_to sub_url(sub_id)
  end
  
  def edit
    @post = Post.find(params[:id])
    render :edit
  end
  
  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    render :new
  end
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  def update
    @post = Post.find(params[:id])
    if (@post.is_author?(current_user)) && @post.update_attributes(post_params)
      flash[:notice] = ["Post updated successfully."]
      redirect_to sub_url(@post.sub)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(
      :title,
      :url,
      :content,
      :sub_id,
      shared_sub_ids: []
    )
  end
end