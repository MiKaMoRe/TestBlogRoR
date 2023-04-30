class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).joins(:author).page(params[:page]).per(12)
  end

  def show
    @post = Post.joins(:author).find(params[:id])
  end
end
