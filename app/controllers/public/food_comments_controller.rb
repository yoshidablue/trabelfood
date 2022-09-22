class Public::FoodCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.food_comments.new(food_comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post)
    else
      render :show
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    FoodComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(@post)
  end

  private

  def food_comment_params
    params.require(:food_comment).permit(:comment, :star)
  end

end