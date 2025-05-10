class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :find_params
  before_action :redirect_if_invalid_access, only: [:index, :create]
  

  def index
    redirect_to root_path if current_user == @item.user
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(
      :postcode, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
end

  def find_params
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_access
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp::Charge.create(
    amount: @item.price,  
    card: order_address_params[:token],    
    currency: 'jpy'   
    )              
  end




