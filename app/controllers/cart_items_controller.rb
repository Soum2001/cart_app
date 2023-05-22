class CartItemsController < ApplicationController
  before_action :cart_items, only:[:create, :update]

  def create
    if @cart_item 
      @cart_item.update(quantity: @cart_item.quantity+1)
    else
      @cart_id = current_user.cart.id
      @cart_item = CartItem.create(cart_id: @cart_id, product_id: params[:product_id],quantity: 1)
      #flash[:notice] = 'New product added'
      # respond_to do |format|
      #   format.html{ redirect_to cart_index_path }
      # end
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    if(params[:act]=="inc")
        @cart_item.quantity =  @cart_item.quantity+1
    else
      @cart_item.quantity =  @cart_item.quantity-1
      if @cart_item.quantity==0
        @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to cart_index_path
  end

  private
  def cart_items
    @cart_item = current_user.cart.cart_items.find_by(product_id: params[:product_id])
  end
end


