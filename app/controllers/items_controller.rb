class ItemsController < ApplicationController
before_action :authenticate_user! ,except: [:index]


  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :price, :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_days_id).merge(user_id: current_user.id)
  end

end
