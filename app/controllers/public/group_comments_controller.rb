class Public::GroupCommentsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @comment = current_customer.group_comments.new(group_comment_params)
    @comment.group_id = @group.id
    if @comment.save
      redirect_to group_path(@group)
    else
      render :show
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    GroupComment.find_by(id: params[:id], group_id: params[:group_id]).destroy
    redirect_to group_path(@group)
  end

  private

  def group_comment_params
    params.require(:group_comment).permit(:comment)
  end

end