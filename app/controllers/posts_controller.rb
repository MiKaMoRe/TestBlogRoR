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
end
