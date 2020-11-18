class BuysController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  before_action :user_prevent
  def index
    @buy_shipment = BuyShipment.new
  end

  def create 
    @buy_shipment = BuyShipment.new(buy_params)
    if @buy_shipment.valid?
      pay_item
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

  def user_prevent
    if (current_user.id == @item.user_id) || @item.buy
      redirect_to root_path
    end
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
  end

end
