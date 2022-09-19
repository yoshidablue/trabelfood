class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts

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

    # current_customerをEntriesテーブルから探す
    @currentCustomerEntry = Entry.where(customer_id: current_customer.id)
    # DMを送る対象のユーザーをEntriesテーブルから探す
    @customerEntry = Entry.where(customer_id: @customer.id)
    if @customer.id != current_customer.id
      # currentCustomerと@customerのEntriesをそれぞれ一つずつ取り出し、２人のroomが既に存在するかを確認
      @currentCustomerEntry.each do |cu|
        @customerEntry.each do |c|
          # ２人のrommが既に存在していた場合
          if cu.room_id == c.room_id
            @isRoom = true
            # room_idを取り出す
            @roomId = cu.room_id
          end
        end
      end
      # ２人のroomが存在しない場合
      unless @isRoom
        # roomとentryを新規に作成する
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def index
    @customers = Customer.all
    @post = Post.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render :edit
    end
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)

    @fdivs = []
    @favorite_posts.each do |post|
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

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :name, :prefecture_id, :food)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end