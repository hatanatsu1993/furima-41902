class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :find_params, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
  end
  
  def edit
    redirect_to root_path unless current_user == @item.user
  end
    
def update
  if @item.update(item_params)
    redirect_to item_path(@item)
  else
    render 'edit', status: :unprocessable_entity
  end
end


#  def destroy
#    item = Item.find(params[:id])
#    item.destroy
#    redirect_to root_path
#  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id,
                                 :delivery_fee_id, :prefecture_id, :shipping_day_id, :price, :image)
          .merge(user_id: current_user.id)
  end

  def find_params
    @item = Item.find(params[:id])
    end
  end




