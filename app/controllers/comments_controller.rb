class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      flash[:notice] = ["Comment created successfully."]
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    render :new
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
  
end