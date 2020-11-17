class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :seller_prevent
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
  def buy_params
    params.require(:buy_shipment).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def seller_prevent
    item = Item.find(params[:item_id])
    if current_user.id == item.user_id
      redirect_to root_path
    end
  end

end

