class Admin::PostsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:food_name, :introduction, :prefecture_id, :comment)
  end

end
