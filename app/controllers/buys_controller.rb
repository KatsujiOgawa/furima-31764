class BuysController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  before_action :seller_prevent
  before_action :sold_out_prevent
  def index
    @buy_shipment = BuyShipment.new
  end

  def new
  end

  def create 
    @buy_shipment = BuyShipment.new(buy_params)
    if @buy_shipment.valid?
      @buy_shipment.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buy_params
    params.require(:buy_shipment).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def seller_prevent
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def sold_out_prevent
    if @item.buy
      redirect_to root_path
    end
  end
  
end
