class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).joins(:author).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end
end
