class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).joins(:author).all
  end

  def show
    @post = Post.find(params[:id])
  end
end
