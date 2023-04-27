class CartItemsController < ApplicationController
    def create
        @product_id = params[:product_id]
        @cart_item = current_user.cart.cart_items.find_by(product_id: @product_id)
        if @cart_item 
          CartItem.update(quantity: @cart_item.quantity+1)
          flash[:notice] = 'New product added'
          redirect_to cart_index_path
        else
          @cart_id = current_user.cart.id
          @cart_item = CartItem.new(cart_id: @cart_id, product_id: @product_id,quantity: 1)
          @cart_item.save
          flash[:notice] = 'New product added'
          redirect_to cart_index_path
        end
    end

    def update
      @product_id = params[:id]
      @cart_item = current_user.cart.cart_items.find_by(product_id: @product_id)
      if(params[:act]=="inc")
          @cart_item.quantity =  @cart_item.quantity+1
      else
        @cart_item.quantity =  @cart_item.quantity-1
      end
      @cart_item.save
      redirect_to cart_index_path
    end
end


