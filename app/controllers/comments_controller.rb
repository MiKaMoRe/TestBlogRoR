class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    raise CanCan::AccessDenied unless can?(:manage, @comment)
    flash[:alert] = @comment.errors.full_messages unless @comment.save

    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end