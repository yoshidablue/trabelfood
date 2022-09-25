class Admin::GroupCommentsController < ApplicationController

  def destroy
    @group = Group.find(params[:group_id])
    GroupComment.find_by(id: params[:id], group_id: params[:group_id]).destroy
    redirect_to admin_group_path(@group)
  end

  private

  def group_comment_params
    params.require(:group_comment).permit(:comment)
  end

end