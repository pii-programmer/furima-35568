class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @items = Item.includes(:user).order("created_at DESC")
    #query = "SELECT * FROM items ORDER BY items.id DESC"
    #@items = Item.find_by_sql(query)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :price, :image, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_delivery_id).merge(user_id: current_user.id)
  end
end
