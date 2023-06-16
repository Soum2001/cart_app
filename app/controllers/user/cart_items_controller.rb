class User::CartItemsController < ApplicationController
  before_action :cart_items, only:[:create, :update]

  def create
    @cart_id = current_user.cart.id
    if @cart_item 
      @cart_item.update(quantity: @cart_item.quantity+1)
    else
      @cart_item = CartItem.create(cart_id: @cart_id, product_id: params[:product_id],quantity: 1)
      #flash[:notice] = 'New product added'
    end
    @count = CartItem.where(cart_id: @cart_id).count
    respond_to do |format|
       format.js
    end
  end

  def destroy 
    id = params[:id]
    item = CartItem.find(id)
    item.destroy
    redirect_to user_carts_path
  end

  def update
    # if(params[:quantity]=="increment")
    #   @cart_item.quantity =  @cart_item.quantity+1
    # else
    #   @cart_item.quantity =  @cart_item.quantity-1
    #   if @cart_item.quantity==0
    #     @cart_item.delete
    #   end
    # end
    # @cart_item.save
    @cart_item.set_quantity params
    respond_to do |format|
      format.js
    end
  end

  private
  def cart_items
    @cart_item = current_user.cart.cart_items.find_by(product_id: params[:product_id])
  end
end


