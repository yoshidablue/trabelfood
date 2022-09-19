class Public::MessagesController < ApplicationController

  def create
    if Entry.where(:customer_id => current_customer.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:customer_id, :content, :room_id).merge(:customer_id => current_customer.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end

end