class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :move_to_index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:postal_cord, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_order
    @item = Item.find(params[:item_id])
  end

  def pay_item
    @price = Item.find(params[:item_id]).price
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

  def move_to_index
    if @item.order.blank? || @item.order.present? || (current_user.id != @item.user_id) && (current_user.id == @item.user_id)
      redirect_to root_path
    end
  end

end
