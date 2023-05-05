class CartItemsController < ApplicationController
  respond_to  :js
    def create
        @product_id = params[:product_id]
        @cart_item = current_user.cart.cart_items.find_by(product_id: @product_id)
        if @cart_item 
          @cart_item.update(quantity: @cart_item.quantity+1)
        else
          @cart_id = current_user.cart.id
          @cart_item = CartItem.new(cart_id: @cart_id, product_id: @product_id,quantity: 1)
          @cart_item.save
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
      @product_id = params[:id]
      @cart_item = current_user.cart.cart_items.find_by(product_id: @product_id)
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
end


