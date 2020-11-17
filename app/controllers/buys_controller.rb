class BuysController < ApplicationController
  before_action :authenticate_user!
  
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

end

