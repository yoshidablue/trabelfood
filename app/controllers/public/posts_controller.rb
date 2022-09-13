class Public::PostsController < ApplicationController

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.new
    @food_comment = FoodComment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    # pluckはmapと同じ意味です
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def create
    @post = current_customer.posts.new(post_params)
    @post.customer_id = current_customer.id
    # 受け取った値を , で区切って配列にする
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def search_tag
    # 検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    # 検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 検索されたタグに紐づく投稿を表示
    @posts = @tag.posts(params[:page])
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:food_name, :introduction, :prefecture_id, :comment)
  end

end



def index
  # @postsに、タグ検索でヒットした投稿を全て代入して、viewに返そうとしてる。
  @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all

  # params[:tag_id]は、「タグ検索画面で、指定したタグ(例: 漬物)のidがわたってくる
  # 一番上の「タグで絞り込み」というメニューを選んだまま検索ボタンが押されたら？ → params[:tag_id]がnil(空の値になっている)
  if params[:tag_id].present? # params[:tag_id]に値があるの？ yes/no → プルダウンでタグが選択されている？されていない？
    # タグが選ばれてきた場合の検索結果を返してあげてる
    # Tag.find(params[:tag_id]) <- Tag.find(id)で、Tagデータから指定されたidのデータを見つけてくる。
    # Tag.find(params[:tag_id]).posts <- 見つけてきたタグデータに紐づく全てのpostを取得する。
    @posts = Tag.find(params[:tag_id]).posts
  else
    # タグが選ばれていない -> 全ての投稿を返す仕様にしている
    @posts = Post.all
  end

end