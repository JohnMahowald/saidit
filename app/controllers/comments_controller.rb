class CommentsController < ApplicationController

  before_action :ensure_logged_in

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = ["Comment created successfully."]
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    render :new
  end
  
  def show
    @comment = Comment.find(params[:id])
    render :show
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
  
end