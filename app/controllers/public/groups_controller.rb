class Public::GroupsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @groups = Group.new
    @group_comment = GroupComment.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def create
    @group = Group.new(group_params)
    @group.owner_customer_id = current_customer.id
    @group.group_customers.build(customer_id: current_customer.id)
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    # current_customerは、@group.customersから消されるという記述
    @group.customers.delete(current_customer)
    redirect_to groups_path
  end

  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
      redirect_to groups_path
    end
  end

  def new
    @group = Group.new
  end

  def join
    @group = Group.find(params[:group_id])
    @group.customers << current_customer
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :comment)
  end

end