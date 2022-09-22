class Admin::PostsController < ApplicationController

  def index
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:star_count]
      @posts = Post.star_count
    else
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all.order("created_at DESC")
    end

    @fdivs = []
    @posts.each do |post|
      stars = []
      post.food_comments.each do |food_comment|
        stars.push(food_comment.star.to_i)
      end
      fdiv = stars.sum.fdiv(stars.length)

      if fdiv.nan?
        fdiv = ""
      end
      @fdivs.push(fdiv)
    end
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

  def search
    prefecture = Prefecture.all
    keyword = params[:keyword]
    res = prefecture.find_by(name: keyword)
    if res != nil
      @posts = Post.search_prefecture(res.id)
    else
      @posts = Post.search(params[:keyword])
    end

    # 並び替え
    if params[:latest]
      @posts = @posts.latest
    elsif params[:old]
      @posts = @posts.old
    elsif params[:star_count]
      # Post.left_joins(:comments).where('postの検索条件').group(:id).order('avg(comments.star) desc')
      @posts = @posts.left_joins(:food_comments).group(:id).order('avg(food_comments.star) desc')
    end

    @fdivs = []
    @posts.each do |post|
      stars = []
      post.food_comments.each do |food_comment|
        stars.push(food_comment.star.to_i)
      end
      fdiv = stars.sum.fdiv(stars.length)

      if fdiv.nan?
        fdiv = ""
      end
      @fdivs.push(fdiv)
    end
  end

  private

  def post_params
    params.require(:post).permit(:food_name, :introduction, :prefecture_id, :comment, :image)
  end

end
