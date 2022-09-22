class Admin::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order("created_at DESC")

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

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :name, :prefecture_id, :food, :is_deleted)
  end

end
