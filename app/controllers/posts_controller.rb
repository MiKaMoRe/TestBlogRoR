class PostsController < ApplicationController
  before_action :find_post, only: %i[destroy edit update]

  skip_before_action :authenticate_user!, only: %i[index show]

  load_and_authorize_resource

  def index
    @posts = posts_filter.includes(:author).joins(:author).page(params[:page]).per(12)
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

  def destroy
    return flash[:alert] = ['Permissions denied'] unless can?(:manage, @post)

    @post.destroy
    flash[:notice] = ['Post has been deleted']
    redirect_to posts_path
  end

  def edit; end

  def update
    return flash[:alert] = ['Permissions denied'] unless can?(:manage, @post)

    if @post.update(post_params)
      flash[:notice] = ['Post has been updated']
      return redirect_to post_path(@post)
    end

    flash[:alert] = @post.errors.full_messages
    render :edit, status: :unprocessable_entity
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

  def posts_filter
    if current_user
      return current_user.posts if params[:only_my]
    end

    Post
  end
end
