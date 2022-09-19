class Admin::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def index
    @customers = Customer.all
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
