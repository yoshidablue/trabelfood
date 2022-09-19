class Admin::FoodCommentsController < ApplicationController

  def destroy
    @post = Post.find(params[:post_id])
    FoodComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to admin_post_path(@post)
  end

  private

  def food_comment_params
    params.require(:food_comment).permit(:comment)
  end

end
