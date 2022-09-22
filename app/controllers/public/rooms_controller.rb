class Public::RoomsController < ApplicationController

  def create
    @room = Room.create
    # current_customerのEntry
    @entry1 = Entry.create(room_id: @room.id, customer_id: current_customer.id)
    # DMを受け取る側のEntry(customers/showでcustomer_idは渡しているため、room_idを拾って、マージしている)
    @entry2 = Entry.create((entry_params).merge(room_id: @room.id))
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    # entriesテーブルにcurrent_customer.idと紐づいたチャットルームがあるかどうか確認
    if Entry.where(customer_id: current_customer.id, room_id: @room.id).present?
      @messages = @room.messages.order("created_at DESC")
      @message = Message.new
      # チャットルームのユーザー情報を表示させるため代入
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:customer_id, :room_id)
  end

end