class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  load_and_authorize_resource

  def index
    @posts = Post.includes(:author).joins(:author).page(params[:page]).per(12)
  end

  def show
    @post = Post.joins(:author).find(params[:id])
  end

  def new; end

  def create
    @post = current_user.posts.build(post_params)

    return flash[:alert] = ['Permissions denied'] unless can?(:manage, @post)
    return redirect_to @post if @post.save

    flash[:alert] = @post.errors.full_messages
    render new_post_path, status: :unprocessable_entity
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
