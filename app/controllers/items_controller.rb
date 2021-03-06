class ItemsController < ApplicationController
before_action :set_item, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user! ,except: [:index, :show]
before_action :move_index, only: [:edit, :destroy]

  def index
    @items = Item.all.order(created_at: "DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :info, :price, :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id).merge(user_id: current_user.id)
  end

  def move_index
    if (current_user != @item.user) || @item.buy
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
