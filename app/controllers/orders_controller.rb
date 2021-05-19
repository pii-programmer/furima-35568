class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order,     only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order = Order.create(user_id: current_user.id, item_id: @item.id)
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
    params.require(:order_address).permit(:postal_cord, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, order_id: @order.id, token: params[:token])
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
    @item = Item.find(params[:item_id])
    if user_signed_in? || @item.order.present?
      redirect_to root_path
    end
  end

end
